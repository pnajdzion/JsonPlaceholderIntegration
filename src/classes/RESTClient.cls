public class RESTClient implements Queueable, Database.AllowsCallouts{
    
    protected String API_NAME;
    protected String API_ADDRESS;
    protected String API_USERNAME;
    protected String API_KEY;
    protected String AUTH_NAME;
    protected String AUTH_TYPE;
    protected String method;
    protected String resource;
    protected String jsonBody;

    protected ApiRestResponseHandler responseHandler;
    
    protected Map<String, String> headers = new Map<String, String> {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
    };

    public RESTClient(String apiName){
        ExternalSystemService__mdt ws = getExternalServiceByName(apiName);
        this.API_ADDRESS = ws.Address__c;
        this.API_USERNAME = ws.Username__c;
        this.API_KEY = ws.Key__c;
        this.AUTH_NAME = ws.AuthorizationName__c;
        this.AUTH_TYPE = ws.AuthorizationType__c;
    }

    public void executeAsync(QueueableContext context){
        HttpRequest req = RESTRequestBuilder.buildJSONRequest(API_ADDRESS + resource, method, headers, jsonBody);
	    Http http = new Http();
	    HTTPResponse res = http.send(req);
        responseHandler.setResponse(res).handleResponse();
    }

    public HttpResponse executeSync(){
        // create method to execute Sync callout
    }

    private ExternalSystemService__mdt getExternalServiceByName(String name){
        ExternalSystemService__mdt[] esList = [SELECT Address__c, Username__c, 
                                                    Key__c, AuthorizationName__c,
                                                    AuthorizationType__c
                                                FROM ExternalSystemService__mdt 
                                                WHERE DeveloperName =: name LIMIT 1];   
        if(esList.isEmpty()){
            throw new CustomException('Web service with given API NAME not found');
        }
        return esList[0];
   }
}
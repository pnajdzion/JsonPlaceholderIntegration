public class RESTRequestBuilder {
    
    public static HTTPRequest buildJSONRequest(String endpoint, String method, Map<String, String> headers, String jsonBody) {
        System.debug('endpoint ' + endpoint);
        System.debug('method ' + method);
        System.debug('headers ' + headers);
        System.debug('jsonBody ' + jsonBody);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod(method);
        
        for(String key : headers.keySet()){
            req.setHeader(key, headers.get(key));
        }
        
        if(method != 'GET' && jsonBody != null){
            req.setBody(jsonBody);    
        }
        
        return req;
    }
}
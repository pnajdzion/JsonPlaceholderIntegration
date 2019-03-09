public class RESTResponseHandler{
    
    protected HTTPResponse response;

    public RESTResponseHandler(){}

    public ApiRestResponseHandler setResponse(HTTPResponse response){
        this.response = response;
        // handle response codes HttpHelper.handleResponseStatusCode(response.getStatusCode());
        return this;
    }

    public class GetPhotosResponseHandler extends RESTResponseHandler{
        public override Object handleResponse(){
            
        }
    }
}
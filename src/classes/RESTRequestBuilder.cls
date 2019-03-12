public class RESTRequestBuilder {
    
    public static HTTPRequest buildJSONRequest(String endpoint, String method, Map<String, String> headers, String jsonBody) {
        
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

public class RESTOperations extends RESTClient {

    public RESTOperations(String API_NAME){
        super(API_NAME);
        //super.headers.put(AUTH_NAME, AUTH_TYPE + ' ' + EncodingUtil.base64Encode(Blob.valueOf(API_USERNAME + ':' + API_KEY)));
    }

    public void getPhotos(){
        super.method = 'GET';
        super.resource = '/photos';
        super.headers = headers;
        super.jsonBody = '{}';
        super.responseHandler = new RESTResponseHandler.GetPhotosResponseHandler();

        System.enqueueJob(this);
    }
}
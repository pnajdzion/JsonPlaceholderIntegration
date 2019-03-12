public class RESTOperations extends RESTClient {

    public RESTOperations(String API_NAME){
        super(API_NAME);
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

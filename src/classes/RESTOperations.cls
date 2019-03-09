public class ApiRESTOperations extends ApiRestClient {

    private static final String API_NAME = 'JSON_Placeholder';

    public ApiRESTOperations(){
        super(API_NAME);
        super.headers.put(AUTH_NAME, AUTH_TYPE + ' ' + EncodingUtil.base64Encode(Blob.valueOf(API_USERNAME + ':' + API_KEY)));
    }

    public HttpResponse getPhotos(){
        super.method = 'GET';
        super.resource = '/photos';
        super.headers = headers;
        super.jsonBody = '{}';
        return executeSync();
    }
}
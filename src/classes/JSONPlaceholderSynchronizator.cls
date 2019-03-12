global class JSONPlaceholderSynchronizator implements Schedulable {
    
    private static final String API_NAME = 'JSON_Placeholder';

	global void execute(SchedulableContext ctx) {
		RESTOperations restOperations = new RESTOperations(API_NAME);
        	restOperations.getPhotos();
	}
}

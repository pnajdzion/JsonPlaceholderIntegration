@IsTest
public class JSONPlaceholderSynchronizatorTest {

    @IsTest
    static void testExecute(){
    	Test.startTest();

       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
       	mock.setStaticResource('JSONPhotosTest');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;');
        Test.setMock(HttpCalloutMock.class, mock);
    	System.schedule('JSON Placeholder Photos', '0 26 12 * * ?', new JSONPlaceholderSynchronizator());
    	
    	Test.stopTest();
    }
}
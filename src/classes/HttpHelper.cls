public class HttpHelper {
    
    private final static Set<Integer> SUCCESS_STATUS_CODES = new Set<Integer>{
       200, 201, 202, 203, 204, 205, 206, 207, 208, 226, 
       300, 301, 302, 303, 304, 305, 307, 308
    };

    public static void handleResponseStatusCode(Integer statusCode) {
       
       if(!SUCCESS_STATUS_CODES.contains(statusCode)){
           Developer.saveLogs(true);
       }
       
       if (isResponseBadRequest(statusCode)) {
            throw new HttpException('400', 'API responded with a 400 : Bad Request');
       } else if (isResponseAccountExpiredFound(statusCode)) {
            throw new HttpException('403', 'API responded with a 403 : No credits or account expired');
       } else if (isResponseNotFound(statusCode)) {
            throw new HttpException('404', 'API responded with a 404 : Not Found');
       } else if (isResponseConflictFound(statusCode)) {
            throw new HttpException('409', 'API responded with a 409 : Conflict');
       } else if (isResponseInternalServerError(statusCode)) {
            throw new HttpException('500', 'API responded with a 500 : Internal Server Error');
       }
   }

   private static Boolean isResponseInternalServerError(Integer responseCode) {
        return (responseCode == 500);
   }
    
   private static Boolean isResponseBadRequest(Integer responseCode) {
        return (responseCode == 400);
   }
   
   private static Boolean isResponseAccountExpiredFound(Integer responseCode) {
        return (responseCode == 403);
   }
    
   private static Boolean isResponseNotFound(Integer responseCode) {
        return (responseCode == 404);
   }

   private static Boolean isResponseConflictFound(Integer responseCode) {
        return (responseCode == 409);
   }  

   public class HttpException extends Exception {
       public String statusCode;

       public HttpException(String statusCode, String msg){
           setMessage(msg);
           this.statusCode = statusCode;
       }
   }
}
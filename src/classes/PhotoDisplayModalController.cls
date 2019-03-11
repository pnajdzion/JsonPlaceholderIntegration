public class PhotoDisplayModalController {

    public PhotoDisplayModalController(){}

    @AuraEnabled
    public static Photo__c[] findPhotoRecords(String titleFilter){
        String query = 'SELECT Id, Album_Id__c, External_Id__c, Title__c, Url__c, Thumbnail_Url__c ';
        query += 'FROM Photo__c ';
        if(! String.isBlank(titleFilter)){
            query += 'WHERE Title__c LIKE \'%' + titleFilter + '\'';
        }
        return Database.query(query);
    }
}
public class MODAL_SendEmailController{

    @AuraEnabled
    public static void sendEmail(String email, Photo__c[] photoList){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {email};
        message.subject = 'Photo List';
        message.plainTextBody = String.valueOf(photoList);
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.sendEmail(messages);
    }
}
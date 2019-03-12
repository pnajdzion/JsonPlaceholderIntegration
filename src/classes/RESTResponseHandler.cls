public virtual class RESTResponseHandler{
    
    protected HTTPResponse response;

    public RESTResponseHandler(){}

    public RESTResponseHandler setResponse(HTTPResponse response){
        this.response = response;
        HttpHelper.handleResponseStatusCode(response.getStatusCode());
        return this;
    }

    public virtual Object handleResponse(){
        return null;
    }

    public class GetPhotosResponseHandler extends RESTResponseHandler{
        public override Object handleResponse(){
            RESTPhotosDto[] dtoList = (RESTPhotosDto[])JSON.deserialize(response.getBody(), RESTPhotosDto[].class);
            Photo__c[] photos = createPhotosFromDto(dtoList);
            Photo__c[] photosToDelete = findPhotosToDelete(photos);
            try{
                Database.delete(photosToDelete);
                Database.upsert(photos, Photo__c.Fields.External_Id__c);
            }catch(Exception e){
                throw new CustomException('There were some issue while doing DML Action with Photos ' + e.getMessage());
            }
            return null;
        }

        private Photo__c[] createPhotosFromDto(RESTPhotosDto[] dtoList){
            Photo__c[] photos = new Photo__c[]{};
            for(RESTPhotosDto dto : dtoList){
                Photo__c photo = new Photo__c(Album_Id__c = dto.albumId,
                                            External_Id__c = dto.id,
                                            Thumbnail_Url__c = dto.thumbnailUrl,
                                            Title__c = dto.title,
                                            Url__c = dto.url);
                photos.add(photo);
            }
            return photos;
        }

        private Photo__c[] findPhotosToDelete(Photo__c[] photos){
            Photo__c[] photosToDelete = new Photo__c[]{};
            Set<String> photosExternalIdSet = new Set<String>();
            for(Photo__c photo: photos){
                photosExternalIdSet.add(photo.External_Id__c);
            }
            Map<String, Photo__c> photoRecords = buildPhotoExternalIdToRecordMap();

            for(String key : photoRecords.keySet()){
                if(! photosExternalIdSet.contains(key)){
                    photosToDelete.add(photoRecords.get(key));
                }
            }

            return photosToDelete;
        }

        private Map<String, Photo__c> buildPhotoExternalIdToRecordMap(){
            Photo__c[] photoList = [SELECT Id, External_Id__c FROM Photo__c];
            Map<String, Photo__c> photoExternalIdToRecordMap = new Map<String, Photo__c>();

            for(Photo__c photo : photoList){
                photoExternalIdToRecordMap.put(photo.External_Id__c, photo);
            }
            return photoExternalIdToRecordMap;
        }
    }
}
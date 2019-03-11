public virtual class RESTResponseHandler{
    
    protected HTTPResponse response;

    public RESTResponseHandler(){}

    public RESTResponseHandler setResponse(HTTPResponse response){
        this.response = response;
        // handle response codes HttpHelper.handleResponseStatusCode(response.getStatusCode());
        return this;
    }

    public virtual Object handleResponse(){
        return null;
    }

    public class GetPhotosResponseHandler extends RESTResponseHandler{
        public override Object handleResponse(){
            RESTPhotosDto[] dtoList = (RESTPhotosDto[])JSON.deserialize(response.getBody(), RESTPhotosDto[].class);
            Photo__c[] photos = createPhotosFromDto(dtoList);
            try{
                Database.upsert(photos, Photo__c.Fields.External_Id__c);
            }catch(Exception e){
                throw new CustomException('There were some issue while upserting Photos ' + e.getMessage());
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
    }
}
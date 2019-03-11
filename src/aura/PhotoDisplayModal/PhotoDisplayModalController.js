({
    doInit: function(component, event, helper){
        helper.getPhotoRecords(component);
    },

    handleApplyFilterClick: function(component, event, helper){
        helper.getPhotoRecords(component);
    },

    handleSendEmailClick: function(component, event, helper){
        helper.createModalComponent(component);
    }
})
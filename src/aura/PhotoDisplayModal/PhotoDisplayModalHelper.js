({
    getPhotoRecords: function(component){
        component.set('v.showSpinner', true);
        var action = component.get('c.findPhotoRecords');
        action.setParams({
            titleFilter: component.get('v.titleFilter')
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.showSpinner', false);
                component.set('v.records', response.getReturnValue());
            } else if (state === "ERROR") {
                component.set('v.showSpinner', false);
                $A.get("e.force:closeQuickAction").fire();
                var errors = response.getError();
                if (errors) {
                    this.showErrorToast(errors);
                }
            }
        });
        $A.enqueueAction(action);
    },

    showErrorToast: function(errorMsg){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "message": errorMsg,
            "type": "error"
        });
        toastEvent.fire();
    },

    createModalComponent: function(component){
        component.set('v.showSpinner', true);
        var modalBody;
        $A.createComponent("c:MODAL_SendEmail", 
                            {
                                records: component.get("v.records")
                            },
                           	function(content, status) {
                               if (status === "SUCCESS") {
                                   component.set('v.showSpinner', false);
                                   modalBody = content;
                                   component.find('overlayLib').showCustomModal({
                                       header: 'Send to email',
                                       body: modalBody, 
                                       showCloseButton: true
                                   })   
                               }else{
                                    component.set('v.showSpinner', true);
                               }
                            }
        );
    }
})

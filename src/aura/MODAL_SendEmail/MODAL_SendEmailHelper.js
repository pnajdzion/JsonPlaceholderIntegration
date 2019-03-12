({
    sendEmailWithRecordList: function(component){
        var action = component.get('c.sendEmail');
        action.setParams({
            email: component.get('v.email'),
            photoList: component.get('v.records')
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": 'Email with Photo list was send!',
                    "type": "success"
                });
                toastEvent.fire();
            } else if (state === "ERROR") {
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
    }
})
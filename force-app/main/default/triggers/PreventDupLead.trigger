Trigger PreventDupLead on Lead(before update) {
    PreventDupLeadTriggerHandler handler = new PreventDupLeadTriggerHandler();
    // For Before Update
    if(Trigger.isUpdate && Trigger.isBefore){
        handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.OldMap,Trigger.newMap);
    }
}
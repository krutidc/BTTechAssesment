trigger EventTrigger on Event__c (before insert) {
    if(Trigger.IsInsert && Trigger.isBefore)
    	EventTriggerHandler.limitNoOfEvents(Trigger.New);    
}
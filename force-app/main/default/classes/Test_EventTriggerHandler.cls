@isTest
private class Test_EventTriggerHandler {

    @isTest
    static void testLimitNoOfEvents(){
        
        List<Event__c> eventListToInsert = new List<Event__c>();
        
        for(Integer i = 0; i <= 200; i++){
            Event__c event = new Event__c();
            event.Name = 'Test Event'+i;
            eventListToInsert.add(event);
        }
        
        Test.startTest();
        try {
            insert eventListToInsert;
         } catch (DmlException e) {
           System.debug('Error expected');
            
         }
            
        Test.stopTest();
    }
}
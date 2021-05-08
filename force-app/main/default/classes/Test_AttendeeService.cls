@IsTest
private class Test_AttendeeService {
    
    @isTest
    static void testcreateAttendee() {
        RestRequest req = new RestRequest();
        System.RestResponse res = new System.RestResponse();
        
        Event__c evt = new Event__c();
        evt.Name = 'TestEvent';
        insert evt;
        
        List<AttendeeService.EventAttendee> evtAtt = new List<AttendeeService.EventAttendee>();
        AttendeeService.EventAttendee att = new AttendeeService.EventAttendee();
        att.firstName = 'test1';
        att.lastName = 'test1';
        att.email = 'test1@xyz.com';
        att.eventId = evt.Id;
        evtAtt.add(att);
        
        req.requestURI = '/services/apexrest/AttendeeService';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JSON.serialize(evtAtt));
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        AttendeeService.createAttendee();
        Test.stopTest();

        System.assertNotEquals(null, res.responseBody.toString());
        
        Attendee__c createdatt = [Select Id From Attendee__c Where Email__c = 'test1@xyz.com' Limit 1];
        System.assertNotEquals(null, createdatt.Id);
    }
}
@RestResource(urlMapping='/AttendeeService/*')
global class AttendeeService {

    public class EventAttendee {
        public String firstName;
        public String lastName;
        public String email;
        public String eventId;
    }

    @HttpPost
    global static void createAttendee() {
        RestUtils.setupRequest();
        EventAttendee[] evntatt = (EventAttendee[]) JSON.deserialize(RestUtils.getBody(),List<EventAttendee>.class);
        List<Attendee__c> attendees = new List<Attendee__c>();
        try {  
            for(EventAttendee att : evntatt){
            if(att.eventId == null){
                RestResponse responseObj = new RestResponse();
                responseObj.addError('Missing Required Query Parameter eventId');
                responseObj.generateResponse();
            }
            else{
                Attendee__c attd = new Attendee__c();
                attd.First_Name__c = att.firstname;
                attd.Last_Name__c = att.lastname;
                attd.Email__c = att.email;
                attd.Event__c = att.eventId;
                attd.Status__c = 'Registered';
                attd.Registration_Date__c = System.today();
                attendees.add(attd);
            }   
        }
        insert attendees;   
        RestResponse responseObj = new RestResponse(attendees);
        responseObj.generateResponse();  
   } catch (Exception e) {
       RestResponse responseObj = new RestResponse();
       responseObj.addError(e.getMessage() + e.getStackTraceString());
       responseObj.generateResponse();
   }          
}
    
}
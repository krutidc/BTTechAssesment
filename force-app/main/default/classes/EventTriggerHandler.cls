public class EventTriggerHandler {
    public static void LimitNoOfEvents(List<Event__c> eventList) {
        Integer monthNumber = Date.Today().Month();
        Integer yearNumber = Date.Today().Year();

        //Custom setting config for events max limit
        Events_Settings__c eventSetting = [SELECT Id, Max_Events_Limit__c FROM Events_Settings__c LIMIT 1];
        Integer configEventMaxCount = (Integer.valueOf(eventSetting.Max_Events_Limit__c));
        List<Event__c> thisMonthEventList = [SELECT Id,CreatedById,CreatedDate FROM Event__c WHERE CALENDAR_YEAR(CreatedDate) =:YearNumber and CALENDAR_MONTH(CreatedDate)=:monthnumber and CreatedById=:UserInfo.GetUserId()];
        
        if (thisMonthEventList.Size()>=configEventMaxCount)         
            eventList[0].addError('Too many Events created this month for user ' + UserInfo.getName() +'('+ userinfo.getuserId()+'):' + thisMonthEventList.Size());
    }
}
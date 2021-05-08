public class GetMinuteSpentEvents {
    @AuraEnabled(cacheable=true)
    public static Event__c getMinSpent(Id recordId) {
        return [SELECT Minutes_Spent__c FROM Event__c WHERE Id = :recordId];
    }
}
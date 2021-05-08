public class PreventDupLeadTriggerHandler
 {
   
   public void OnBeforeUpdate(List<Lead> oldlead, List<Lead> newlead, Map<Id, Lead> oldleadMap, Map<Id, Lead> newleadMap){
    
    Map<String, Lead> leadMap = new Map<String, Lead>();
    for(Lead lead : newlead){
        if(lead.Email != null && oldleadMap.get(lead.id).Email <> newleadMap.get(lead.id).Email){
            leadMap.put(lead.Email, lead);
        }
    }
    for (Lead lead : [SELECT Email FROM Lead WHERE Email IN :leadMap.KeySet()]) {
        leadMap.get(lead.Email).Email.addError('A lead with this email address already exists.');
    }
}          
}
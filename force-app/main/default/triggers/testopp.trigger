Trigger testopp on Opportunity(before update,before insert) {
    For(Opportunity p : Trigger.New){

        List<Account> acc = [Select Id, SLASerialNumber__c FROM Account where id=:p.AccountId];
        if(p.CloseDate < TODAY()){
        p.StageName='Closed';
        p.RecordType='renewal';
        }
        p.TrackingNumber__c= acc.SLASerialNumber__c;
        }
}
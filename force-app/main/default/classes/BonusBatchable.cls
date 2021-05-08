public class BonusBatchable implements Database.Batchable<sObject>, Database.stateful {

    public Database.QueryLocator start(Database.BatchableContext BC) {
        String query;

        query = 'Select Id, Start_Date__c, End_Date__c From Bonus__c Where Is_Processed__c = false ORDER BY Name ASC LIMIT 10000';

        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Bonus__c> scope) {

    try {
        List<Bonus_Payouts__c> payoutsDates = new List<Bonus_Payouts__c>();
        List<Bonus__c> updateProcessed = new List<Bonus__c>();

        for(Bonus__c bonus : scope){
            for(Integer i = 0 ; i < (bonus.Start_Date__c.monthsBetween(bonus.End_Date__c) + 1); i++){
                //month start and end date
                Bonus_Payouts__c pay = new Bonus_Payouts__c();
                pay.Payout_Start_Date__c = bonus.Start_Date__c.toStartofMonth().addMonths(i);
                pay.Payout_End_Date__c = bonus.Start_Date__c.addMonths(1+i).toStartofMonth().addDays(-1);
                pay.Bonus__c = bonus.Id;
                payoutsDates.add(pay);
            }
            if(!payoutsDates.isEmpty()){
            bonus.Is_Processed__c = true;
            updateProcessed.add(bonus);
            }
        }

    insert payoutsDates;

    if(!updateProcessed.isEmpty()){
    update updateProcessed; 
    }
    
}
    catch (Exception ex) {
        System.debug(ex);
    }
    }

    public void finish(Database.BatchableContext BC) {
      
    }

}
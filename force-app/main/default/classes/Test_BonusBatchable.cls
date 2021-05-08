@isTest 
public class Test_BonusBatchable 
{
    static testMethod void testMethod1() 
    {

        List<Bonus__c> lstbonus= new List<Bonus__c>();
        for(Integer i=0 ;i <200;i++)
        {
            Bonus__c bon = new Bonus__c();
            bon.Start_Date__c = System.today();
            bon.End_Date__c = System.today().addMonths(2);
            lstbonus.add(bon);
        }
        
        insert lstbonus;
        
        Test.startTest();
            BonusBatchable obj = new BonusBatchable();
            DataBase.executeBatch(obj); 
         Test.stopTest();

         Set<Id> bonSet = new Set<Id>();
            for(Bonus__c bon : lstbonus){
                bonSet.add(bon.Id);
            }

         List<Bonus_Payouts__c> pays = [SELECT Id, Bonus__r.Is_Processed__c FROM Bonus_Payouts__c WHERE Bonus__c IN : bonSet];
            for(Bonus_Payouts__c bp : pays){
           System.assertEquals(true, bp.Bonus__r.Is_Processed__c);
        }
        System.assertEquals(600, pays.size());
        
    }
}
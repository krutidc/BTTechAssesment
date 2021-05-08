@IsTest
private class Test_PreventDupLeadTriggerHandler {
    @isTest
    static void testOnBeforeUpdate() {
    
        Lead lead1 = new Lead(LastName='Test1', Company='Test1 Inc.',
        Email='test1@duptest.com');
        Lead lead2 = new Lead(LastName='Test2', Company='Test2 Inc.',
        Email='test4@duptest.com');
        Lead lead3 = new Lead(LastName='Test3', Company='Test3 Inc.',
        Email='test5@duptest.com');
        Lead[] leads = new Lead[] {lead1, lead2, lead3};
        insert leads;

        lead2.Email = 'test2@duptest.com';
        lead3.Email = 'test3@duptest.com';
        update leads;
          
    // single row lead duplication prevention on update.
      Lead dup11 = new Lead(Id = lead1.Id, LastName='Test1Dup',
      Company='Test1Dup Inc.',
      Email='test2@duptest.com');
        try {
        update dup11;
        } catch (DmlException e) {
        System.assert(e.getNumDml() == 1);
        System.assert(e.getDmlIndex(0) == 0);
        System.assert(e.getDmlFields(0).size() == 1);
        System.assert(e.getDmlFields(0)[0].getDescribe().getName() == 'Email');
        System.assert(e.getDmlMessage(0).indexOf(
        'A lead with this email address already exists.') > -1);
        }
      // bulk lead duplication prevention on update
        Lead dup1 = new Lead(Id=lead1.Id, Email='test4@duptest.com');
        Lead dup2 = new Lead(Id=lead2.Id, Email='test2@duptest.com');
        Lead dup3 = new Lead(Id=lead3.Id, Email='test1@duptest.com');
        Lead[] dups = new Lead[] {dup1, dup2, dup3};
        try {
           update dups;
        } catch (DmlException e) {
           System.debug(e.getNumDml());
           System.debug(e.getDmlMessage(0));
           System.assert(e.getNumDml() == 1);
           System.assert(e.getDmlIndex(0) == 2);
           System.assert(e.getDmlFields(0).size() == 1);
           System.assert(e.getDmlFields(0)[0].getDescribe().getName() == 'Email');
           System.assert(e.getDmlMessage(0).indexOf(
              'A lead with this email address already exists.') > -1);
          }
          
    }
}
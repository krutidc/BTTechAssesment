@IsTest
public with sharing class Test_RestUtils {

    @isTest
    static void testGetBody() {
        Boolean isSuccess = false;
        try {
            RestUtils.getBody();
            isSuccess = true;
        }
        catch (Exception e) {

        }
        System.assert(!isSuccess);
    }
}
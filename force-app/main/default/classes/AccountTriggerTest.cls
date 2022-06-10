/**
* @description AccountTriggerTest test class for AccountTrigger.
* @Created By: Arun Kumar
* @Last Modified Date : 06-04-2022
*/
@isTest
public class AccountTriggerTest {
    private static final String TERRITORY_OWNER_LAST_NAME = 'Test User';
    private static final String TERRITORY_NAME = '91010';
    
    @testSetup
    public static void testRecords(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='testuser@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Test User', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='testuser100@testorg.com');
        insert u;
        //insert Territory record
        Territory__c terr = new Territory__c();
        terr.Name = '91010';
        terr.OwnerId = u.Id;
        
        insert terr;
        
    }
    @isTest
    public static void testAccountTrigger(){
        
        List<Account> accList = new List<Account>();
        for( Integer i = 0; i< 200; i++ ){
            Account acc = new Account (Name = 'Test Account '+ i,
                                       BillingPostalCode = '91000');
            accList.add(acc);
        }
        insert accList;
        
        system.assertEquals(200, accList.size());
        
        Test.startTest();
        
        accList[0].BillingPostalCode = '91010';
        update accList;
        
        system.assertEquals(AccountTriggerTest.TERRITORY_NAME, accList[0].BillingPostalCode);
        
        Account updatedAccount = [Select id,Owner.LastName from Account where Id=: accList[0].Id];
        system.assertEquals(AccountTriggerTest.TERRITORY_OWNER_LAST_NAME, updatedAccount.Owner.LastName);
        
        Test.stopTest();
    }
    @isTest
    public static void testMultipleTerritoryWithSameName(){
        List<Territory__c> territoryList = new List<Territory__c>();
        for(integer i = 0; i < 3; i++){
            Territory__c terr = new Territory__c();
            terr.Name = AccountTriggerTest.TERRITORY_NAME;
            territoryList.add(terr);
        }
        insert territoryList;
        system.assertEquals(3, territoryList.size());
        Test.startTest();
        Account acc = new Account (Name = 'Test Account ',
                                   BillingPostalCode = AccountTriggerTest.TERRITORY_NAME);
        //insert account
        insert acc;
        Test.stopTest();
    }
    @isTest
    public static void testDeleteAccountRecord(){
        Test.startTest();
        Account acc = new Account (Name = 'Test Account ',
                                   BillingPostalCode = '91000');
        insert acc;
        //test delete logic
        delete acc;
        //test undelete logic
        undelete acc;
        Test.stopTest();
    }
}
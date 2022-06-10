/**
* @description TerritoryTriggerTest test class for TerritoryTrigger.
* @Created By: Arun Kumar
* @Last Modified Date : 06-04-2022
*/
@isTest
public class TerritoryTriggerTest {
	private static final String TERRITORY_NAME = '91010';
    @isTest
    public static void testTerritoryTriggerLogic(){
      	Test.startTest();
        List<Territory__c> territoryList = new List<Territory__c>();
        for(integer i = 0; i < 3; i++){
            Territory__c terr = new Territory__c();
            terr.Name = TerritoryTriggerTest.TERRITORY_NAME;
            
            territoryList.add(terr);
        }
        insert territoryList;
        system.assertEquals(3,territoryList.size());
        
        territoryList[0].Name = '91020';
		update territoryList;
        system.assertEquals('91020', territoryList[0].Name);
        Test.stopTest();
    }
    
     @isTest
    public static void testDeleteTerritoryRecord(){
        Test.startTest();
        Territory__c terr = new Territory__c();
        terr.Name = TerritoryTriggerTest.TERRITORY_NAME;
        insert terr;
        //test delete logic
        delete terr;
        //test undelete logic
        undelete terr;
        Test.stopTest();
    }
}
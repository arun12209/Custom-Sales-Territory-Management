/**
 * @description TerritoryTriggerHelper class to write trigger logic
 * @Created By: Arun Kumar
 * @Last Modified Date : 05-04-2022
*/
public class TerritoryTriggerHelper {
	
     public TerritoryTriggerHelper() {
        //system.debug('Inside TerritoryTriggerHelper Constructor');
    }
    /**
     * @description vaildateTerritoryCreation method checks if system already have the 3 sales rep assigned to zip code.
     * @param newTerritories
    */
    public void vaildateTerritoryCreation(List<Territory__c> newTerritories){
        Set<String> zipCodeName = new Set<String>();
        Map<String, Integer> territoryOwnerCountMap = new Map<String, Integer>();
        
        for(Territory__c t : newTerritories){
            zipCodeName.add(t.Name);
        }
        
        for(AggregateResult aggr: [Select Name zip, count(ownerId) cnt from Territory__c WHERE Name IN:zipCodeName Group by Name]){
            territoryOwnerCountMap.put(String.valueOf(aggr.get('zip')), Integer.valueOf(aggr.get('cnt')));
        }
        
        for(Territory__c terr: newTerritories){
            if(territoryOwnerCountMap.containsKey(terr.Name)){
                //check if system already have the 3 sales rep assigned to zip code going to create. 
                if(territoryOwnerCountMap.get(terr.Name) == 3){
                    //Block the Territory creation and display the message.
                    terr.addError(Label.Only_3_sales_representatives_at_most_can_be_assigned_to_a_single_zip_code);
                }
            }
        }
    }
}
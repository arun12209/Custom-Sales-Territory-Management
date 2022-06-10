/**
 * @description TerritoryTriggerHandler class handles trigger events and invokes helper method to perform the business logic.
 * @Created By: Arun Kumar
 * @Last Modified Date : 05-04-2022
*/
public class TerritoryTriggerHandler implements TriggerHandler{
	
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public TerritoryTriggerHelper helper;
    public TerritoryTriggerHandler(Boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new TerritoryTriggerHelper();
    }

    public void beforeInsert(List<Territory__c> newTerritories){
        helper.vaildateTerritoryCreation(newTerritories);
    }
    public void beforeUpdate(List<Territory__c> newTerritories, List<Territory__c> oldTerritories, Map<Id,sObject> newTerritoryMap, Map<Id,sObject> oldTerritoryMap){
        
        Map<Id,Territory__c> newTerrMap = (Map<Id,Territory__c>)newTerritoryMap;
        Map<Id,Territory__c> oldTerrMap = (Map<Id,Territory__c>)oldTerritoryMap;
        List<Territory__c> territoryList = new List<Territory__c>();
        for(Territory__c terr: newTerritories){
            //check if owner OR Name is changed.
            if( (newTerrMap.get(terr.Id).OwnerId != oldTerrMap.get(terr.Id).OwnerId) ||
                (newTerrMap.get(terr.Id).Name != oldTerrMap.get(terr.Id).Name)){
                territoryList.add(terr);
            }
        }
        if(territoryList.size()>0){
            //call helper method to validate the record.
            helper.vaildateTerritoryCreation(territoryList);
        }
    }
	
    public void beforeDelete(List<Territory__c> oldTerritories, Map<Id,SObject> oldTerritoryMap){
        //write before delete logic here
    }

    public void afterInsert(List<Territory__c> newTerritories, Map<Id,SObject> newTerritoryMap){
    	//write after insert logic here
    }
    public void afterUpdate(List<Territory__c> newTerritories, List<Territory__c> oldTerritories, Map<Id,SObject> newTerritoryMap, Map<Id,SObject> oldTerritoryMap){
        //write after update logic here
    }

    public void afterDelete(List<Territory__c> oldTerritories, Map<Id,SObject> oldTerritoryMap){
        //After Delete logic here
    }

    public void afterUndelete(List<Territory__c> newTerritories, Map<Id,SObject> newTerritoryMap){
        //After undelete logic here
    }
}
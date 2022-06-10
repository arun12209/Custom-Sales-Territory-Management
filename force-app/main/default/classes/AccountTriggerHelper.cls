public without sharing class AccountTriggerHelper {
    //Constructor 
    public AccountTriggerHelper() {
        //system.debug('Inside AccounttriggerHelper Constructor');
    }
    /**
     * @description updateAccountOwner method updates accounts owner records.
     * @param accList
    */
    public void updateAccountOwner(List<Account> accList){
        Set<String> zipCodeSet = new Set<String>();
        //Map<zipCode, salesRepId>
        Map<String,String> territoryMap = new Map<String,String>();
        for(Account acc: accList){
            if(acc.BillingPostalCode !=''){
                zipCodeSet.add(acc.BillingPostalCode);
            }
        }
        if(zipCodeSet.size()>0){
            territoryMap = getTerritoryRecord(zipCodeSet);
            
            for(Account acc: accList){
                if(territoryMap.containsKey(acc.BillingPostalCode)){
                    //update owner with territory owner
                    acc.OwnerId = territoryMap.get(acc.BillingPostalCode);
                }
            }
        }
    }
    /**
     * @description getTerritoryRecord method query the territory records and retruns Map<zipCode,ownerId>, 
     * if more than record found with same zipcode then it gets random record.
     * @param Map<String,String>
    */
    public Map<String,String> getTerritoryRecord(Set<String> zipcodes) {
        Territory__c territoryRecord ;
        Map<String,String> zipCodeSalesRepMap = new Map<String,String>();
        Integer count = [SELECT COUNT() FROM Territory__c WHERE Name in :zipcodes];
        
        if(count == 1){
            territoryRecord = [SELECT Id,Name,OwnerId FROM Territory__c WHERE Name in :zipcodes LIMIT 1];
            zipCodeSalesRepMap.put(territoryRecord.Name, territoryRecord.OwnerId);
        }
        else if(count > 1){
            //generate the random number for OFFSET
            Integer randomNumber = Math.floor(Math.random() * count).intValue();
            territoryRecord = [SELECT Id,Name,OwnerId FROM Territory__c WHERE Name in :zipcodes LIMIT 1 OFFSET :randomNumber];
            zipCodeSalesRepMap.put(territoryRecord.Name, territoryRecord.OwnerId);
        }
        return zipCodeSalesRepMap;
    }
    
}
public without sharing class AccountTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public AccountTriggerHelper helper;
    public AccountTriggerHandler(Boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new AccountTriggerHelper();
    }

    public void beforeInsert(List<Account> newAccounts){
        helper.updateAccountOwner(newAccounts);
    }
    public void beforeUpdate(List<Account> newAccounts, List<Account> oldAccopunts, Map<Id,sObject> newAccountMap, Map<Id,sObject> oldAccountMap){
        //************** Update Account Owner *************************
        Map<Id,Account> newAccMap = (Map<Id,Account>)newAccountMap;
        Map<Id,Account> oldAccMap = (Map<Id,Account>)oldAccountMap;
        List<Account> accList = new List<Account>();
        for(Account acc: newAccounts){
            //check if billing postal code changed.
            if( newAccMap.get(acc.Id).BillingPostalCode != oldAccMap.get(acc.Id).BillingPostalCode){
                accList.add(acc);
            }
        }
        if(accList.size()>0){
            //call helper method to update the accounts owner.
            helper.updateAccountOwner(newAccounts);
        }
        //************* END *******************************************
    }
	
    public void beforeDelete(List<Account> oldAccounts, Map<Id,SObject> oldAccountMap){
        //write before delete logic here
    }

    public void afterInsert(List<Account> newAccounts, Map<Id,SObject> newAccountMap){
        //write after insert logic here

    }
    public void afterUpdate(List<Account> newAccounts, List<Account> oldAccounts, Map<Id,SObject> newAccountMap, Map<Id,SObject> oldAccountMap){
        //write after update logic here
    }

    public void afterDelete(List<Account> oldAccounts, Map<Id,SObject> oldAccountMap){
        //After Delete logic here
    }

    public void afterUndelete(List<Account> newAccounts, Map<Id,SObject> newAccountMap){
        //After undelete logic here
    }
}
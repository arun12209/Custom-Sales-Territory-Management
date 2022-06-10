public interface TriggerHandler {

    // ********** before methods *******************
    void beforeInsert(List<sObject> newRecords);
    void beforeUpdate(List<sObject> newRecords, List<sObject> oldRecords, Map<Id,sObject> newRecordMap, Map<Id,sObject> oldRecordMap);
    void beforeDelete(List<sObject> oldRecords, Map<Id,sObject> oldRecordMap);

    // *********** after methods ********************
    void afterInsert(List<sObject> newRecords, Map<Id,sObject> newRecordMap);
    void afterUpdate(List<sObject> newRecords, List<sObject> oldRecords, Map<Id,sObject> newRecordMap, Map<Id,sObject> oldRecordMap);
    void afterDelete(List<sObject> oldRecords, Map<Id, sObject> oldRecordMap);
    void afterUndelete(List<sObject> newRecords, Map<Id,sObject> newRecordMap);
    
}
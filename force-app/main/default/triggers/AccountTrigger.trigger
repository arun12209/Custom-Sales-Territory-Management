/**
 * @description AccountTrigger.
 * @Created By: Arun Kumar
 * @Last Modified Date : 05-04-2022
*/
trigger AccountTrigger on Account (before insert,before update, before delete, after insert, after update, after delete,after undelete) {

        TriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);

        switch on Trigger.operationType {
            when BEFORE_INSERT {
                //call before insert handler method
                handler.beforeInsert(Trigger.new);
            }
            when BEFORE_UPDATE {
                //call before update handler method
                handler.beforeUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
            }
            when BEFORE_DELETE{
                //call before delete handler method
                handler.beforeDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_INSERT{
                //call after insert handler method
                handler.afterInsert(Trigger.new,Trigger.newMap);
            }
            when AFTER_UPDATE{
                //call after update handler method
                handler.afterUpdate(Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap);
            }
            when AFTER_DELETE{
                //call after delete handler method
                handler.afterDelete(trigger.old, Trigger.oldMap);
            }
            when AFTER_UNDELETE{
                //call after undelete handler method
                handler.afterUndelete(trigger.new, Trigger.newMap);
            }
        }

}
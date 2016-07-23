public class SpeakerListController {
    // ApexPages.StandardSetController must be instantiated
    // for standard list controllers
    public ApexPages.StandardSetController setController {
        get {
            if(setController == null) {
                setController = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT Id, Name, Contact__r.FirstName, Contact__r.LastName, 
                        Session__c, Send_Thank_You_Beer__c
                        FROM Speaker__c]));
            }
            return setController;
        }
        set;
    }

    // Initialize setController and return a list of records
    public List<Speaker__c> getSpeakers() {
        return (List<Speaker__c>) setController.getRecords();
    }
}
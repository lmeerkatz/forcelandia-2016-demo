global class PostSandboxRefresh implements SandboxPostCopy{
	global void runApexClass(SandboxContext context) {
        List<Session> sessions = getSessionList();
        insertContacts(sessions);   
        insertSessions(sessions);
        insertSpeakers(sessions);
    }

    private void insertContacts(List<Session> sessions) {
        // assume last names are unique
        Map<String, Contact> contacts = new Map<String, Contact>();

        for (Session sessn : sessions) {
            if (!contacts.containsKey(sessn.lastName)) {
                contacts.put(sessn.lastName, new Contact(
                    FirstName = sessn.firstName,
                    LastName = sessn.lastName
                ));
            }   
        }
        insert contacts.values();
    }

    private void insertSessions(List<Session> sessions) {
        List<Session__c> sessionsToInsert = new List<Session__c>();
        for (Session sessn : sessions) {
            sessionsToInsert.add(new Session__c(
                Name = sessn.sessionName
            ));
        }
        insert sessionsToInsert;
    }

    private void insertSpeakers(List<Session> sessions) {
        // assumes session names are unique
        Map<String, Id> sessionMap = new Map<String, Id>();
        for (Session__c sessn : [ SELECT Id, Name FROM Session__c ]) {
            sessionMap.put(sessn.Name, sessn.Id);
        }

        // assumes last names are unique
        Map<String, Id> contactMap = new Map<String, Id>();
        for (Contact con : [ SELECT Id, LastName FROM Contact ]) {
            contactMap.put(con.LastName, con.Id);
        }

        List<Speaker__c> speakers = new List<Speaker__c>();
        for (Session sessn : sessions) {
            speakers.add(new Speaker__c(
                Contact__c = contactMap.get(sessn.lastName),
                Session__c = sessionMap.get(sessn.sessionName)
            ));
        }
        insert speakers;
    } 


    private List<Session> getSessionList() {
        List<Session> sessions = new List<Session>();
        sessions.add(new Session('Daniel', 'Peter', 'Querying Millions of Records using the Bulk API'));
        sessions.add(new Session('Laura', 'Meerkatz', 'Dev Tools for Admins'));
        sessions.add(new Session('Jean Michel', 'Mougeolle', 'Images in Salesforce: Why it matters now for a developer'));
        sessions.add(new Session('Christian', 'Carter', 'Use Custom Metadata Types for a Better App Builder Experience'));
        sessions.add(new Session('Zayne', 'Turner', 'What every Admin should know about Apex'));
        sessions.add(new Session('Beth', 'Breisnes', 'Use Custom Metadata Types for a Better App Builder Experience'));
        sessions.add(new Session('Samantha', 'Ready', 'Trailhead Superbadges'));
        sessions.add(new Session('Kieren', 'Jameson', 'Triggers'));
        sessions.add(new Session('Melissa', 'Prcic', 'Heroku'));
        sessions.add(new Session('Skip', 'Sauls', 'Wave App Development'));
        sessions.add(new Session('Leah', 'McGowan-Hare', 'Keynote'));
        sessions.add(new Session('Alex', 'Toussaint', 'Wave App Development'));
        sessions.add(new Session('Bonny', 'Hinners', 'What every Admin should know about Apex'));
        sessions.add(new Session('Dan', 'Appleman', 'Unit Testing for Admins'));
        sessions.add(new Session('Lyric', 'Hartley', 'Heroku'));
        sessions.add(new Session('Samantha', 'Ready', 'Salesforce.com'));
        sessions.add(new Session('Simon', 'Goodyear', 'Irrevocable Actions'));
        sessions.add(new Session('Michelle', 'Rowley', 'Heroku'));
        sessions.add(new Session('Daniel', 'Hoechst', 'Using Continuous Integration with Force.com'));
        sessions.add(new Session('Kieren', 'Jameson', 'Trailhead'));
        return sessions;
    }

    class Session {
        String firstName { get; set; }
        String lastName { get; set; }
        String sessionName { get; set; }

        Session( String firstName, String lastName, String sessionName ) {
            this.firstName = firstName;
            this.lastName = lastName;
            this.sessionName = sessionName;
        }
    }
}
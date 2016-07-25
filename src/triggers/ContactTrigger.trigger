trigger ContactTrigger on Contact (before insert, before update) {
    for (Contact con : Trigger.new) {
        if (con.FirstName == 'Steve') {
            con.addError('Steves are highly suspect and should not be included in our speaker list.');
        }
    }
}
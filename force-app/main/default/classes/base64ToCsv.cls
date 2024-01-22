public class base64ToCsv {
    public static void updateLeadOwnerIds(String contentDocumentId) {
        // Fetch CSV content from ContentVersion
        ContentVersion cDocu = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :contentDocumentId];
        Blob csvBlob = cDocu.VersionData;  
        String csvContent = csvBlob.toString();

        // Parse CSV content
        List<String> csvLines = csvContent.split('\n');
        Map<String, String> zipToUserNameMap = new Map<String, String>();

        for (String line : csvLines) {
            List<String> fields = line.split(',');
            if (fields.size() >= 2) { // Assuming the CSV has at least two columns (Zip Code and UserName)
                String zipCode = fields[0].trim();
                String userName = fields[1].trim();
                zipToUserNameMap.put(zipCode, userName);
            }
        }
        
        system.debug('zipToUserNameMap===> '+zipToUserNameMap);

        // Query User records based on User Names
        Map<String, Id> userNameToIdMap = new Map<String, Id>();
        for (User userRecord : [SELECT Id, Name FROM User WHERE Name IN :zipToUserNameMap.values() ]) {
            userNameToIdMap.put(userRecord.Name, userRecord.Id);
        }
        
        system.debug('userNameToIdMap====> '+userNameToIdMap);
        
        // Update Lead OwnerIds based on Zip Code
        List<Lead> leadsToUpdate = [SELECT Id, OwnerId, PostalCode FROM Lead WHERE PostalCode IN :zipToUserNameMap.keySet()];

        for (Lead leadRecord : leadsToUpdate) {
            String zipCode = leadRecord.PostalCode;
            if (zipToUserNameMap.containsKey(zipCode) && userNameToIdMap.containsKey(zipToUserNameMap.get(zipCode))) {
                leadRecord.OwnerId = userNameToIdMap.get(zipToUserNameMap.get(zipCode));
            } else {
                // Handle the case where a matching user ID is not found for the given zip code
                // You may want to log an error, skip the record, or take appropriate action
                System.debug('No matching user ID found for zip code: ' + zipCode);
            }
        }
        
        System.debug('leadsToUpdate===> '+leadsToUpdate);
        
        // Update Lead records
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
    }
}
public class UpdateParentPySalesHelper {
    // Helper method to calculate the sum of py_sales__c for child accounts
/*    public static Decimal getSumOfChildSales(Id parentId) {
        Decimal totalSales = 0;

        // Query child accounts and calculate the sum
        List<Account> childAccounts = [SELECT Py_Sales__c FROM Account WHERE ParentId = :parentId];
        for (Account child : childAccounts) {
            totalSales += child.Py_Sales__c != null ? child.Py_Sales__c : 0;
        }

        return totalSales;
    }

    // Helper method to update the Segment__c picklist based on Py_Sales__c total
    public static void updateSegmentPicklist(List<Account> parentAccounts) {
        // List to store accounts with updated Segment__c picklist value
        List<Account> accountsToUpdate = new List<Account>();

        for (Account parentAccount : parentAccounts) {
            String segmentValue = UpdateParentPySalesHelper.determineSegmentValue(parentAccount.Py_Sales__c);
            // Check if the Segment__c value needs to be updated
            if (parentAccount.Segment__c != 'Tier 1') {
                accountsToUpdate.add(new Account(
                    Id = parentAccount.Id,
                    Segment__c = segmentValue
                ));
            }
        }

        // Update accounts with the new Segment__c value
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }

    // Helper method to determine the Segment__c value based on Py_Sales__c total
    public static String determineSegmentValue(Decimal pySalesTotal) {
        // Define your logic for determining the Segment__c value based on Py_Sales__c total
        if (pySalesTotal >= 300000) {
            return 'Tier 1';
        } else if (pySalesTotal >= 100000 && pySalesTotal <= 299000) {
            return 'Tier 2';
        } else if (pySalesTotal >= 10000 && pySalesTotal <= 99000) {
            return 'Tier 3';
        } else if (pySalesTotal < 10000) {
            return 'Tier 4';
        } else {
            return '1';
        }
    }		*/
}
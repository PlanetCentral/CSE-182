SELECT Drug.drugID as theDrugID, Purchase.purchaseTimestamp as thePurchaseTimestamp
FROM Drug
inner join DrugsInPurchase on Drug.drugID=DrugsInPurchase.drugID
left join Purchase on DrugsInPurchase.purchaseID=Purchase.purchaseID
left join Pharmacy on Purchase.pharmacyID=Pharmacy.pharmacyID
WHERE prescriptionRequired=TRUE 
AND DATE(purchaseTimestamp)>='2024-01-24' 
AND Pharmacy.address LIKE '%en%'
AND Purchase.creditCardNumber IS NULL 
group by Purchase.purchaseTimestamp, Drug.DrugID
having SUM(DrugsInPurchase.quantity)>=2;

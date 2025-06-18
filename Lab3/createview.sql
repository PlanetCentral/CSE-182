CREATE VIEW BadTotalPriceView AS
SELECT p.purchaseID,
       p.customerID,
       p.pharmacyID,
       p.purchaseTimestamp,
       p.totalPrice,
       p.creditCardType,
       p.creditCardNumber,
       p.expirationDate,
       SUM(dip.subtotal) AS totalDrugPrice
FROM Purchase p
JOIN DrugsInPurchase dip ON p.purchaseID = dip.purchaseID
GROUP BY p.purchaseID,
         p.customerID,
         p.pharmacyID,
         p.purchaseTimestamp,
         p.totalPrice,
         p.creditCardType,
         p.creditCardNumber,
         p.expirationDate
HAVING ABS(p.totalPrice - SUM(dip.subtotal)) >= 1;


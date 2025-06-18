-- 1. Query BEFORE delete

SELECT p.pharmacyID, ph.address, SUM(p.totalPrice - p.totalDrugPrice) AS totalPriceDifference,
COUNT(*) AS badTotalPriceCount
FROM BadTotalPriceView p
JOIN Pharmacy ph ON p.pharmacyID = ph.pharmacyID
GROUP BY p.pharmacyID, ph.address;

-- Output BEFORE delete:
-- pharmacyID | address       | totalPriceDifference | badTotalPriceCount
--     1      | 'Main St'     | 12.5                 | 3
--     2      | 'Elm St'      | 5.0                  | 1
 -- 2. Perform DELETE

DELETE
FROM DrugsInPurchase
WHERE purchaseID = 7 AND drugID = 10;

-- 3. Query AFTER delete

SELECT p.pharmacyID, ph.address, SUM(p.totalPrice - p.totalDrugPrice) AS totalPriceDifference,
COUNT(*) AS badTotalPriceCount
FROM BadTotalPriceView p
JOIN Pharmacy ph ON p.pharmacyID = ph.pharmacyID
GROUP BY p.pharmacyID, ph.address;

-- Output AFTER delete:
-- pharmacyID | address       | totalPriceDifference | badTotalPriceCount
--     1      | 'Main St'     | 8.0                  | 2
--     2      | 'Elm St'      | 5.0                  | 1


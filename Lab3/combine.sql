BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

INSERT INTO Supplier(supplierID, supplierName, rating)
SELECT us.supplierID, us.supplierName, 9
FROM UpgradeSupplier us
WHERE NOT EXISTS (
  SELECT 1 FROM Supplier s WHERE s.supplierID = us.supplierID
);

UPDATE Supplier s
SET supplierName = us.supplierName,
    rating = s.rating + 1
FROM UpgradeSupplier us
WHERE s.supplierID = us.supplierID;

COMMIT;


INSERT INTO Purchase(purchaseID, customerID, pharmacyID, purchaseTimestamp, totalPrice)
VALUES (999, -1, 11, NOW(), 10.0);

INSERT INTO Purchase(purchaseID, customerID, pharmacyID, purchaseTimestamp, totalPrice)
VALUES (998, 1, -1, NOW(), 10.0);

INSERT INTO DrugsInPurchase(purchaseID, drugID, quantity, subtotal, discount)
VALUES (-1, 1, 1, 10.0, 0.0);

UPDATE Pharmacy
SET numEmployees = 5
WHERE pharmacyID = 1;

UPDATE Pharmacy
SET numEmployees = 0
WHERE pharmacyID = 1;

UPDATE OrderSupply
SET status = 'dlvd'
WHERE ctid IN (
    SELECT ctid FROM OrderSupply WHERE status IS NULL LIMIT 1
);

UPDATE OrderSupply
SET status = 'invalid'
WHERE ctid IN (
    SELECT ctid FROM OrderSupply WHERE status IS NULL LIMIT 1
);

UPDATE Purchase
SET creditCardType = NULL,
    creditCardNumber = NULL
WHERE ctid IN (
    SELECT ctid FROM Purchase WHERE creditCardType IS NOT NULL LIMIT 1
);

UPDATE Purchase
SET creditCardType = NULL,
    creditCardNumber = 123456789
WHERE ctid IN (
    SELECT ctid FROM Purchase WHERE creditCardType IS NOT NULL LIMIT 1
);

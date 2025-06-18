CREATE TABLE Lab1.Customer(
    customerID INT PRIMARY KEY,
    customerName VARCHAR(40),
    address VARCHAR(50),
    dateOfBirth DATE,
    healthInsuranceName VARCHAR(40)
);

CREATE TABLE Lab1.Pharmacy(
    pharmacyID INT PRIMARY KEY,
    address VARCHAR(50),
    openTime TIME, --(0) gets rid of secs, with out timezone
    closeTime TIME,
    numEmployees INT
);

CREATE TABLE Lab1.Drug(
    drugID INT PRIMARY KEY,
    drugName VARCHAR(40),
    manufacturer VARCHAR(40),
    prescriptionRequired BOOLEAN
);

CREATE TABLE Lab1.Supplier(
    supplierID INT PRIMARY KEY,
    supplierName VARCHAR(40),
    rating INT
);

CREATE TABLE Lab1.Purchase(
    purchaseID INT PRIMARY KEY,
    customerID INT,
    pharmacyID INT,
    purchaseTimestamp TIMESTAMP,
    totalPrice NUMERIC(8,2), --precision, scale, substract 2nd num from first, to get total #'s we wll have
    creditCardType CHAR(1),
    creditCardNumber INT,
    expirationDate DATE
);

CREATE TABLE Lab1.DrugsInPurchase(
    purchaseID INT,
    drugID INT,
    quantity INT,
    subtotal NUMERIC (8,2),
    discount INT,
    PRIMARY KEY(purchaseID, drugID)
);

CREATE TABLE Lab1.OrderSupply(
    pharmacyID INT,
    supplierID INT,
    drugID INT,
    drugPrice NUMERIC (8,2), 
    quantity INT,
    orderDate DATE,
    status CHAR(4),
    PRIMARY KEY(pharmacyID, supplierID, drugID)
);

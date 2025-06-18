-- CSE 182 Spring 2025 Lab3 creation file

-- The following two lines are useful for running tests after you fix bugs.
DROP SCHEMA Lab3 CASCADE;
CREATE SCHEMA Lab3;


CREATE TABLE Customer(
  customerID INT PRIMARY KEY,
  customerName VARCHAR(40),
  address VARCHAR(50),
  dateOfBirth DATE,
  healthInsuranceName VARCHAR(40)
);

CREATE TABLE Pharmacy(
  pharmacyID INT PRIMARY KEY,
  address VARCHAR(50),
  openTime TIME,
  closeTime TIME,
  numEmployees INT
);

CREATE TABLE Drug(
  drugID INT PRIMARY KEY,
  drugName VARCHAR(40),
  manufacturer VARCHAR(40),
  prescriptionRequired BOOLEAN
);

CREATE TABLE Supplier(
  supplierID INT PRIMARY KEY,
  supplierName VARCHAR(40),
  rating INT
);

CREATE TABLE Purchase(
  purchaseID INT PRIMARY KEY,
  customerID INT,
  pharmacyID INT,
  purchaseTimestamp TIMESTAMP,
  totalPrice NUMERIC(8, 2),
  creditCardType CHAR(1),
  creditCardNumber INT,
  expirationDate DATE
);

CREATE TABLE DrugsInPurchase(
  purchaseID INT,
  drugID INT REFERENCES Drug,
  quantity INT,
  subtotal NUMERIC(8, 2),
  discount INT,
  PRIMARY KEY (purchaseID, drugID)
);

CREATE TABLE OrderSupply(
  pharmacyID INT,
  supplierID INT,
  drugID INT REFERENCES Drug,
  drugPrice NUMERIC(8, 2),
  quantity INT,
  orderDate DATE,
  status CHAR(4),
  PRIMARY KEY (pharmacyID, supplierID, drugID)
);

CREATE TABLE UpgradeSupplier (
  supplierID INT PRIMARY KEY,
  supplierName VARCHAR(40)
);

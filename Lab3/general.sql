ALTER TABLE Pharmacy ADD CONSTRAINT pharmacyEmployeesPositive CHECK (numEmployees > 0);

ALTER TABLE OrderSupply ADD CONSTRAINT validOrderStatus CHECK (status IN ('dlvd', 'pndg', 'cnld') OR status IS NULL);

ALTER TABLE Purchase ADD CONSTRAINT ifNullTypeThenNullNumber CHECK ( creditCardType IS NOT NULL 
OR creditCardNumber IS NULL);

select customerName, totalPrice, Pharmacy.address as pharmacyAddress
FROM Lab2.Customer
left join lab2.purchase on Customer.customerID = Purchase.customerID
left join lab2.pharmacy on Pharmacy.pharmacyID = Purchase.pharmacyID
WHERE customerName LIKE 'R%' AND totalPrice>40; --anything starts with R, otherwise youd do it before e.g. %R

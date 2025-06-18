Select distinct pharmacyID as thePharmacyID, OrderSupply.supplierID AS theSupplierID
from OrderSupply
inner join(
Select supplierID, min(orderDate) as orderDate
from OrderSupply
group by supplierID) 
AS minOrderDate on OrderSupply.supplierID=minOrderDate.supplierID and OrderSupply.orderDate=minOrderDate.orderDate;

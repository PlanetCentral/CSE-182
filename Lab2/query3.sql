select o.supplierID as theSupplierID
from OrderSupply o
left join Supplier s on o.supplierID = s.supplierID
where s.supplierName!='McKesson'
group by o.supplierID, o.pharmacyID 
having count(o.drugID)>=2; 

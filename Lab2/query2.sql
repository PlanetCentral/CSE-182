select distinct c.customerID, c.address
from Customer c
left join Lab2.Purchase p on c.customerID = p.customerID
where p.creditCardType='V' and p.customerID not in (select distinct customerID
from Purchase 
where totalPrice>100)
order by c.address desc, c.customerID asc;

select rank() over (order by count(CustomerID) desc) as Rank,
       SalesPerson,
       count(CustomerID) as NumberOfClients
from SalesLT.Customer
group by SalesPerson;
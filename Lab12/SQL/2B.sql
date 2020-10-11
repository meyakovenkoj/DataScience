select dense_rank() over (order by count(SalesOrderID) desc) as Rank,
       SalesPerson,
       count(SalesOrderID) as NumberOfSales
from SalesLT.Customer left join SalesLT.SalesOrderHeader
    on Customer.CustomerID = SalesOrderHeader.CustomerID
group by SalesPerson;
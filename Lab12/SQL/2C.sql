select rank() over (order by sum(LineTotal) desc) as Rank,
       SalesPerson,
       ISNULL(sum(LineTotal), 0) as Income
from SalesLT.Customer left join SalesLT.SalesOrderHeader
    on Customer.CustomerID = SalesOrderHeader.CustomerID
    left join SalesLT.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
group by SalesPerson;
select
ISNULL(CAST(City AS NVARCHAR(30)),
           CASE WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=0 AND GROUPING(CountryRegion)=0 THEN 'Summary by state'
               WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=1 AND GROUPING(CountryRegion)=0 THEN ''
           END
           ) AS City,
ISNULL(CAST(StateProvince AS NVARCHAR(30)),
           CASE WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=0 AND GROUPING(CountryRegion)=0 THEN ''
               WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=1 AND GROUPING(CountryRegion)=0 THEN 'Summary by country'
           END
           ) AS StateProvince,
CountryRegion,
sum(LineTotal) as income,
sum(OrderQty*UnitPrice*UnitPriceDiscount) as discount
from
SalesLT.Customer  join SalesLT.SalesOrderHeader on Customer.CustomerID = SalesOrderHeader.CustomerID
    join SalesLT.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
    join SalesLT.Product on SalesOrderDetail.ProductID = Product.ProductID
    join SalesLT.CustomerAddress on Customer.CustomerID = CustomerAddress.CustomerID
    join SalesLT.Address on CustomerAddress.AddressID = Address.AddressID
group by grouping sets(
(City,StateProvince, CountryRegion),
(StateProvince, CountryRegion),
(CountryRegion)
);
select Product.ProductID,
       SalesPerson,
       SalesOrderHeader.CustomerID,
       City,
       StateProvince,
       CountryRegion,
       ISNULL(sum(OrderQty), 0) as SalesAmount,
--        GROUPING(Product.ProductID),
--        GROUPING(SalesPerson),
--        GROUPING(SalesOrderHeader.CustomerID),
--        GROUPING(City),
--        GROUPING(StateProvince),
--        GROUPING(CountryRegion)
from SalesLT.Product left join SalesLT.SalesOrderDetail on Product.ProductID = SalesOrderDetail.ProductID
    left join SalesLT.SalesOrderHeader on SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
    left join SalesLT.Customer on SalesOrderHeader.CustomerID = Customer.CustomerID
    left join SalesLT.CustomerAddress on Customer.CustomerID = CustomerAddress.CustomerID
    left join SalesLT.Address on CustomerAddress.AddressID = Address.AddressID
group by
grouping sets (
  (City, StateProvince, CountryRegion),
  (StateProvince, CountryRegion),
  (CountryRegion),
  (SalesOrderHeader.CustomerID),
  (SalesPerson),
  (Product.ProductID)
    );
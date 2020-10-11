select Customer.CustomerID,
       Product.ProductID,
       CustomerAddress.AddressID,
       ShipToAddressID,
       BillToAddressID,
       ISNULL(sum(LineTotal),0) as Income
from SalesLT.Customer
    join SalesLT.SalesOrderHeader on Customer.CustomerID = SalesOrderHeader.CustomerID
    join SalesLT.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
    join SalesLT.Product on SalesOrderDetail.ProductID = Product.ProductID
    join SalesLT.CustomerAddress on Customer.CustomerID = CustomerAddress.CustomerID
    join SalesLT.Address on CustomerAddress.AddressID = Address.AddressID
group by cube(
    Product.ProductID,
  Customer.CustomerID,
  ShipToAddressID,
  BillToAddressID,
  CustomerAddress.AddressID
    );
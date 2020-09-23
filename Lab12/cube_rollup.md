Task A

```sql
select ISNULL(CAST(Customer.CustomerID AS NVARCHAR(30)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Итог по покупателю'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по товару'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Подытог по продавцу и товару'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог'
           END
           ) AS CustomerID,
       ISNULL(CAST(SalesPerson AS NVARCHAR(40)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Итог по покупателю'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по товару'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Подытог по товару и покупателю'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог'
           END
           ) AS SalesPerson,
       ISNULL(CAST(Product.ProductID AS NVARCHAR(40)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Итог по покупателю'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по товару'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=0 THEN N'Подытог по покупателю и продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог'
           END
           ) AS ProductID,
       sum(LineTotal) as Income,
       GROUPING(SalesPerson)                  AS grouping_sp,
       GROUPING(Product.ProductID)            AS grouping_pd,
       GROUPING(Customer.CustomerID)          AS grouping_cu
from SalesLT.Customer
    join SalesLT.SalesOrderHeader on Customer.CustomerID = SalesOrderHeader.CustomerID
    join SalesLT.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
    join SalesLT.Product on SalesOrderDetail.ProductID = Product.ProductID
group by cube(Customer.CustomerID, SalesPerson, Product.ProductID);
```

Task A + nulls

```sql
select ISNULL(CAST(Customer.CustomerID AS NVARCHAR(30)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Итог по покупателю'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по товару'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Подытог по продавцу и товару'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог'
           END
           ) AS CustomerID,
       ISNULL(CAST(SalesPerson AS NVARCHAR(40)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Итог по покупателю'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по товару'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Подытог по товару и покупателю'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог'
           END
           ) AS SalesPerson,
       ISNULL(CAST(Product.ProductID AS NVARCHAR(40)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN N'Итог по покупателю'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог по товару'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=0 THEN N'Подытог по покупателю и продавцу'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN N'Итог'
           END
           ) AS ProductID,
       ISNULL(sum(LineTotal),0) as Income,
       GROUPING(SalesPerson)                  AS grouping_sp,
       GROUPING(Product.ProductID)            AS grouping_pd,
       GROUPING(Customer.CustomerID)          AS grouping_cu
from SalesLT.Customer
    left join SalesLT.SalesOrderHeader on Customer.CustomerID = SalesOrderHeader.CustomerID
    join SalesLT.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
    full outer join SalesLT.Product on SalesOrderDetail.ProductID = Product.ProductID
group by cube(Customer.CustomerID, SalesPerson, Product.ProductID);
```

Task B

```sql
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
```

Task C

```sql
select
ISNULL(CAST(City AS NVARCHAR(30)),
           CASE WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=0 AND GROUPING(CountryRegion)=0 THEN N'Итог по штату'
               WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=1 AND GROUPING(CountryRegion)=0 THEN N''
           END
           ) AS City,
ISNULL(CAST(StateProvince AS NVARCHAR(30)),
           CASE WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=0 AND GROUPING(CountryRegion)=0 THEN N''
               WHEN GROUPING(City)=1 AND GROUPING(StateProvince)=1 AND GROUPING(CountryRegion)=0 THEN N'Итог по стране'
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
```

Task D

```sql
select
       ISNULL(CAST(Product.ProductID AS NVARCHAR(30)),
           case
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=0 and GROUPING(B.ProductCategoryID)=0 then N'Итог по категории продукта'
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=0 then N'Итог по род. категории'
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=1 then N'Итог по всем категориям'
            end) as ProductID,
       ISNULL(CAST(A.ProductCategoryID AS NVARCHAR(30)),
           case
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=0 and GROUPING(B.ProductCategoryID)=0 then N''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=0 then N''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=1 then N''
            end) as ProductCategory,
        ISNULL(CAST(B.ProductCategoryID AS NVARCHAR(30)),
           case
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=0 and GROUPING(B.ProductCategoryID)=0 then N''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=0 then N''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=1 then N''
            end) as ParentCategory,
       sum(LineTotal) as Income,
       sum(UnitPrice*UnitPriceDiscount*OrderQty) as Discount
from SalesLT.SalesOrderDetail join SalesLT.Product on SalesOrderDetail.ProductID = Product.ProductID
    join SalesLT.ProductCategory as A on Product.ProductCategoryID = A.ProductCategoryID
    left join SalesLT.ProductCategory as B on A.ParentProductCategoryID=B.ProductCategoryID
group by rollup (B.ProductCategoryID, A.ProductCategoryID, Product.ProductID);
```

Task E

```sql
select Product.ProductID,
       SalesPerson,
       SalesOrderHeader.CustomerID,
       City,
       StateProvince,
       CountryRegion,
       ISNULL(sum(OrderQty), 0) as SalesAmount
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
```

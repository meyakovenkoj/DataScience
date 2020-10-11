select ISNULL(CAST(Customer.CustomerID AS NVARCHAR(30)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN 'Summury by seller'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN 'Summary by customer'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN 'Summary by product'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN 'Subsum by seller and product'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN 'Summary'
           END
           ) AS CustomerID,
       ISNULL(CAST(SalesPerson AS NVARCHAR(40)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN 'Summury by seller'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN 'Summary by customer'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN 'Summary by product'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN 'Subsum by product and customer'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN 'Summary'
           END
           ) AS SalesPerson,
       ISNULL(CAST(Product.ProductID AS NVARCHAR(40)),
           CASE WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=1 THEN 'Summury by seller'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=0 THEN 'Summary by customer'
               WHEN GROUPING(Product.ProductID)=0 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN 'Summary by product'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=0 AND GROUPING(Customer.CustomerID)=0 THEN 'Subsum by customer and seller'
               WHEN GROUPING(Product.ProductID)=1 AND GROUPING(SalesPerson)=1 AND GROUPING(Customer.CustomerID)=1 THEN 'Summary'
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
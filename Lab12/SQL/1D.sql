select
       ISNULL(CAST(Product.ProductID AS NVARCHAR(30)),
           case
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=0 and GROUPING(B.ProductCategoryID)=0 then 'Summary by product cat'
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=0 then 'Summary by parent cat'
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=1 then 'Summary by all cat'
            end) as ProductID,
       ISNULL(CAST(A.ProductCategoryID AS NVARCHAR(30)),
           case
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=0 and GROUPING(B.ProductCategoryID)=0 then ''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=0 then ''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=1 then ''
            end) as ProductCategory,
        ISNULL(CAST(B.ProductCategoryID AS NVARCHAR(30)),
           case
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=0 and GROUPING(B.ProductCategoryID)=0 then ''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=0 then ''
               when GROUPING(Product.ProductID)=1 and GROUPING(A.ProductCategoryID)=1 and GROUPING(B.ProductCategoryID)=1 then ''
            end) as ParentCategory,
       sum(LineTotal) as Income,
       sum(UnitPrice*UnitPriceDiscount*OrderQty) as Discount
from SalesLT.SalesOrderDetail join SalesLT.Product on SalesOrderDetail.ProductID = Product.ProductID
    join SalesLT.ProductCategory as A on Product.ProductCategoryID = A.ProductCategoryID
    left join SalesLT.ProductCategory as B on A.ParentProductCategoryID=B.ProductCategoryID
group by rollup (B.ProductCategoryID, A.ProductCategoryID, Product.ProductID);
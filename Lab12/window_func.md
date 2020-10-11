Task A

```sql
select rank() over (order by count(CustomerID) desc) as Rank,
       SalesPerson,
       count(CustomerID) as NumberOfClients
from SalesLT.Customer
group by SalesPerson;
```

Task B

```sql
select dense_rank() over (order by count(SalesOrderID) desc) as Rank,
       SalesPerson,
       count(SalesOrderID) as NumberOfSales
from SalesLT.Customer left join SalesLT.SalesOrderHeader
    on Customer.CustomerID = SalesOrderHeader.CustomerID
group by SalesPerson;
```

Task С

```sql
select rank() over (order by sum(LineTotal) desc) as Rank,
       SalesPerson,
       ISNULL(sum(LineTotal), 0) as Income
from SalesLT.Customer left join SalesLT.SalesOrderHeader
    on Customer.CustomerID = SalesOrderHeader.CustomerID
    left join SalesLT.SalesOrderDetail on SalesOrderHeader.SalesOrderID = SalesOrderDetail.SalesOrderID
group by SalesPerson;
```

2nd part

Task 2A

```sql
select count(Customer.CustomerID) as NumberOfClients,
       CountryRegion,
       StateProvince,
       percent_rank() over (partition by CountryRegion order by count(Customer.CustomerID)) as PercentRank
from SalesLT.Customer
    join (select * from SalesLT.CustomerAddress where AddressType='Main Office') as CA on Customer.CustomerID = CA.CustomerID
    join SalesLT.Address on CA.AddressID = Address.AddressID
group by CountryRegion, StateProvince
order by CountryRegion, NumberOfClients desc, StateProvince;
```

Task 2B

```sql
select count(Customer.CustomerID) as NumberOfClients,
       CountryRegion,
       StateProvince,
       dense_rank() over (partition by CountryRegion order by count(Customer.CustomerID)) as DenseRank
from SalesLT.Customer
    left join (select * from SalesLT.CustomerAddress where AddressType='Main Office') as CA on Customer.CustomerID = CA.CustomerID
    left join SalesLT.Address on CA.AddressID = Address.AddressID
group by CountryRegion, StateProvince
order by CountryRegion, NumberOfClients desc, StateProvince;
```

Task 2C

```sql
select count(Customer.CustomerID) as NumberOfClients,
       CountryRegion,
       StateProvince,
       City,
       rank() over (partition by CountryRegion order by count(Customer.CustomerID) desc, City) as Rank,
       (count(Customer.CustomerID) - lag(count(Customer.CustomerID)) over (partition by CountryRegion order by count(Customer.CustomerID) desc, City)) as Diff
from SalesLT.Customer
    join (select * from SalesLT.CustomerAddress where AddressType='Main Office') as CA on Customer.CustomerID = CA.CustomerID
    join SalesLT.Address on CA.AddressID = Address.AddressID
group by CountryRegion, StateProvince, City
order by CountryRegion, NumberOfClients desc, City;
```

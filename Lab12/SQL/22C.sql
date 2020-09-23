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
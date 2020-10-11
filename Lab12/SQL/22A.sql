select count(Customer.CustomerID) as NumberOfClients,
       CountryRegion,
       StateProvince,
       percent_rank() over (partition by CountryRegion order by count(Customer.CustomerID)) as PercentRank
from SalesLT.Customer
    join (select * from SalesLT.CustomerAddress where AddressType='Main Office') as CA on Customer.CustomerID = CA.CustomerID
    join SalesLT.Address on CA.AddressID = Address.AddressID
group by CountryRegion, StateProvince
order by CountryRegion, NumberOfClients desc, StateProvince;
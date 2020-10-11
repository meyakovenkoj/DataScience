select count(Customer.CustomerID) as NumberOfClients,
       CountryRegion,
       StateProvince,
       dense_rank() over (partition by CountryRegion order by count(Customer.CustomerID)) as DenseRank
from SalesLT.Customer
    left join (select * from SalesLT.CustomerAddress where AddressType='Main Office') as CA on Customer.CustomerID = CA.CustomerID
    left join SalesLT.Address on CA.AddressID = Address.AddressID
group by CountryRegion, StateProvince
order by CountryRegion, NumberOfClients desc, StateProvince;
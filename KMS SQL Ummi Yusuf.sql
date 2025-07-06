create database KMS3_DB

create table KMSdata3(
Rowid nvarchar (10),
Orderid nvarchar (10),
Orderdate date,
Orderpriority varchar (100),
Orderquantity nvarchar (10),
Sales decimal (10,2),
Discount decimal (10,2),
Shipmode varchar (100),
Profit decimal (10,2),
UnitPrice decimal (10,2),
Shippingcost decimal (10,2),
Customer varchar (100),
Province varchar (100),
Region varchar (100),
Customersegment varchar (100),
Productcategory varchar (100),
productsubcategory varchar (100),
productname varchar (100),
productcontainer varchar (100), 
productbase decimal (10,2),
shipdate date,
primary key (rowid)
)

select * from dbo.kmsdata

insert into KMSdata3 (rowid,orderid,orderdate,orderpriority,Orderquantity,sales,discount,shipmode,profit,unitprice,
shippingcost,customer,province,region,customersegment,productcategory,productsubcategory,productname,productcontainer,
productbase,shipdate)
select Row_ID,Order_ID,Order_Date,Order_Priority,Order_Quantity,sales,discount,ship_mode,profit,Unit_Price,
Shipping_Cost,Customer_Name,province,region,customer_segment,product_category,Product_Sub_Category,product_name,product_container,
Product_Base_Margin,Ship_Date
from dbo.KMSdata

select * from KMSdata3 


----------------Product Category with Highest Sales----------------- is *Technology*

select productcategory, sum(sales) as totalcategorysales
from KMSdata3
group by Productcategory
order by totalcategorysales desc;

------------------top 3 and bottom 3 regions in terms of sales)---------------
----------------top 3 are West, Ontario and Prarie------------
----------------bottom 3 are nunavut, northwest territories and yukon---------

select * from KMSdata3 

select top 3
region,sum(sales) as totalsales
from KMSdata3
group by Region
order by totalsales desc;

select top 3
region,sum(sales) as totalsales
from KMSdata3
group by Region
order by totalsales asc;

-------------------------total sales of appliances in Ontario----------------- 202,346.84
select * from KMSdata3

select sum (sales)as totalsales_appliances_Ontario
from KMSdata3
where
Region='Ontario'
and productsubcategory='appliances';

--------------------what  to do to increase revenue from bottom 10customers--------------------
--I advise that the management should find a way to reduce the shipping cost--
--they can send the customers thank you messages and attach similar products so as to give the customers options
--another way is to get feedback from the customers on how to serve the better---


select * from KMSdata3

select top 10
orderpriority,Orderquantity,sales,discount,profit,unitprice,
shippingcost,productcategory, productsubcategory, Customer
from KMSdata3 
order by Sales asc

----------------------shipping method with most shipping cost--------------------is delivery truck
select * from KMSdata3

select
shipmode,sum (shippingcost) as totalshippingcost
from KMSdata3
group by Shipmode
order by totalshippingcost desc


---------most valuable customers and the products/services purchased---------------technology and office supplies

select * from KMSdata3

select top 10
customer,profit,productcategory,productsubcategory
from KMSdata3
order by Profit desc

--------------small business customer with highest sales----------- Dennis Kane

select * from KMSdata3

select top 1
customer,customersegment, sales
from KMSdata3
where Customersegment='small business'
order by Sales desc


-------------------corporate customer with most number of orders in 2009 to 2012---------Adam Hart

select * from KMSdata3

select top 1
Customer,count (*) as numberoforders
from KMSdata3
where Customersegment='corporate'and
year (orderdate) between 2009 and 2012
group by Customer
order by numberoforders desc

-----------------------most profitable consumer customer--------- Emily Phan

select * from KMSdata3

select customer, profit,customersegment
from KMSdata3
where Customersegment='consumer'
order by profit desc

----------------customers that returned items and their segment---------------419 customers

select * from KMSdata3

create table Returned(
orderID nvarchar (10),
statusoforder varchar (10)
primary key (orderID))

select * from dbo.order_status

insert into Returned(orderID,statusoforder)
select order_ID,[status]
from dbo.order_status


select distinct K.customer,K.customersegment
from KMSdata3 K
inner join Returned R
on K.orderID=R.orderID;


-------------- shipping costs based on the Order Priority---------

select * from KMSdata3

SELECT OrderPriority, ShipMode, sum (shippingcost) as totalshippingcost
FROM KMSdata3
where Shipmode='delivery truck'or
shipmode='express air'
GROUP BY OrderPriority, ShipMode
ORDER BY ShipMode, totalshippingcost desc;

----the company spent shipping did not spend the shipping cost based on order priority
---as seen from the table for delivery truck, high order priority incurred more shipping cost
----and for express Air, critical order priority incurred more, followed by Medium

-----THE END-----



CREATE DATABASE shop;

USE shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
             BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);

select * from customers;
select * from orders;
select * from sellers;

-- 1.Вывести имя продавца и сумму его заказов.
select t1.SNAME, ifnull(t2.AMT,0)
from sellers t1
left join orders t2
on t1.SELL_ID = t2.SELL_ID
where t2.SELL_ID is not null;

-- 2.Вывести имя клиента и сумму его заказов.
select t1.CNAME, t2.AMT
from customers t1
left join orders t2
on t1.CUST_ID = t2.CUST_ID
where t2.CUST_ID is not null;

-- 3.Вывести всех продавцов, включая тех, у кого нет заказов.
select t1.SNAME, ifnull(AMT,0) as sum
from sellers t1
left join orders t2
on t1.SELL_ID = t2.SELL_ID;

-- 4.Вывести все заказы, включая информацию о продавцах, даже если не все продавцы сделали заказы.
select t1.ORDER_ID ,  SNAME 
from orders t1
left join sellers t2
on t1.SELL_ID = t2.SELL_ID;

-- 5.Вывести продавцов и их начальников.
select t1.SNAME as name_SELLERS , t2.SNAME as name_BOSS
from sellers t1
left join sellers t2
on t1.BOSS_ID = t2.SELL_ID;

-- 6.Найти всех клиентов из города "Москва" и суммы их заказов.
select t1.CNAME , t1.CITY, ifnull(t2.AMT,0)
from customers t1
left join orders t2
on t1.CUST_ID = t2.CUST_ID
where t1.CITY = 'Москва';

-- 7.Найти всех продавцов из города "Сочи" и их заказы, если таковые имеются.
select t1.SNAME , t1.CITY, ifnull(t2.AMT,0) as sum
from sellers t1
left join orders t2
on t1.SELL_ID = t2.SELL_ID
where t1.CITY = 'Сочи';

-- 8.Найти всех клиентов с заказами выше 5000 и информацию о продавцах, которые их обслуживали.
select t1.CNAME ,  ifnull(t2.AMT,0) as sum, t3.SNAME
from customers t1
left join orders t2
on t1.CUST_ID = t2.CUST_ID
left join sellers t3
on t2.SELL_ID = t3.SELL_ID
where t2.AMT > 5000;

-- 9.Найти всех продавцов, у которых есть начальники.
select t1.SNAME as name_SELLERS , t2.SNAME as name_BOSS
from sellers t1
left join sellers t2
on t1.BOSS_ID = t2.SELL_ID
where t2.SELL_ID is not null;

-- 10.Вывести пары покупателей и обслуживших их продавцов из одного города.
select t1.CNAME  , t2.SNAME , t1.CITY as CITY_C, t2.CITY as CITY_S
from customers t1
join sellers t2
on t1.CITY = t2.CITY;







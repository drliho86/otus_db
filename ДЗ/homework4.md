Домашнее задание
DDL скрипты для postgres

Цель:
Реализовать спроектированную схему в postgres


Описание/Пошаговая инструкция выполнения домашнего задания:
Используя операторы DDL создайте на примере схемы интернет-магазина:

Базу данных.
Табличные пространства и роли.
Схему данных.
Таблицы своего проекта, распределив их по схемам и
табличным пространствам.


---------------------------------------------------------------------------------------------

CREATE DATABASE shop;

CREATE SCHEMA "groups";

CREATE TABLESPACE ext_tabspace LOCATION '/var/lib/postgresql/15/main/';


CREATE TABLE "groups"."group" (
	id int4 NOT NULL,
	"name" varchar NOT NULL,
	name2 varchar NULL,
	description varchar NULL,
	CONSTRAINT group_pk PRIMARY KEY (id)
)tablespace ext_tabspace;

--------------------------------------------------------------------------------------------------

![image](https://user-images.githubusercontent.com/60733068/229194311-b488b909-e48c-48e0-9083-465953dbb386.png)




![image](https://user-images.githubusercontent.com/60733068/229194006-125f2194-025c-490f-a34a-ed57b56a6143.png)


![image](https://user-images.githubusercontent.com/60733068/229194164-2e8cf7fe-8bd9-42f3-bd97-a5dc3f45b3bf.png)




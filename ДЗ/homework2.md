Домашнее задание
Добавляем в модель данных дополнительные индексы и ограничения

Цель:
Научиться применять индексы в реальном проекте


Описание/Пошаговая инструкция выполнения домашнего задания:
Проводим анализ возможных запросов\отчетов\поиска данных.
Предполагаем возможную кардинальность поля.
Создаем дополнительные индексы - простые или композитные.
На каждый индекс пишем краткое описание зачем он нужен (почему по этому полю\полям).
Думаем какие логические ограничения в БД нужно добавить - например какие поля должны быть уникальны, в какие нужно добавить условия, чтобы не нарушить бизнес логику. Пример - нельзя провести операцию по переводу средств на отрицательную сумму.
Создаем ограничения по выбранным полям.

Критерии оценки:
10 - задача выполнена
9 - задача выполнена но есть претензии

------------------------------------------------------------------------------------------------------------------------------------------------

![diag](https://user-images.githubusercontent.com/60733068/224626816-e9261e02-2650-4d76-a4da-75f1208b16aa.png)


-------------------------------------------------------------------------------------------------------------------------------------------------

-- tbl.customer definition  

-- Drop table  

-- DROP TABLE tbl.customer;  

CREATE TABLE tbl.customer (  
	id int4 NOT NULL,  
	"name" varchar(50) NOT NULL,  
	phone varchar(50) NOT NULL,  
	last_name varchar(50) NOT NULL,  
	sex varchar(50) NOT NULL,  
	birthday timestamp NOT NULL,  
	address varchar(50) NOT NULL,  
	CONSTRAINT pk_1 PRIMARY KEY (id)  
);  
CREATE UNIQUE INDEX customer_phone_idx ON tbl.customer USING btree (phone, name, last_name);  


-- tbl.emploee definition  

-- Drop table  

-- DROP TABLE tbl.emploee;  

CREATE TABLE tbl.emploee (  
	id int4 NOT NULL,  
	"name" varchar(50) NOT NULL,  
	lastname varchar(50) NOT NULL,  
	phone varchar(50) NOT NULL,  
	description varchar(50) NOT NULL,  
	is_work int4 NOT NULL,  
	CONSTRAINT pk_1_emploee PRIMARY KEY (id)  
);  


-- tbl.product definition  

-- Drop table  

-- DROP TABLE tbl.product;  

CREATE TABLE tbl.product (  
	id int4 NOT NULL,
	"name" varchar(50) NOT NULL,  
	weight float8 NULL,  
	height float8 NULL,  
	lenght float8 NULL,  
	id_group1 int4 NULL,  
	id_group2 int4 NULL,  
	description varchar(50) NULL,  
	img_http varchar(50) NULL,  
	CONSTRAINT pk_1_product PRIMARY KEY (id)  
);  


-- tbl.delivery definition  

-- Drop table  

-- DROP TABLE tbl.delivery;  

CREATE TABLE tbl.delivery (  
	id int4 NOT NULL,  
	delivery_ord varchar(50) NULL,  
	id_sotr int4 NULL,  
	begin_time timestamp NULL,  
	end_time timestamp NULL,  
	coord varchar(50) NULL,  
	CONSTRAINT pk_1_delivery PRIMARY KEY (id),  
	CONSTRAINT fk_8_delivery FOREIGN KEY (id_sotr) REFERENCES tbl.emploee(id)  
);  
CREATE INDEX delivery_delivery_ord_idx ON tbl.delivery USING btree (delivery_ord, id_sotr);  


-- tbl.discount definition  

-- Drop table  

-- DROP TABLE tbl.discount;  

CREATE TABLE tbl.discount (  
	id int4 NOT NULL,  
	"name" varchar(50) NOT NULL,  
	amount float8 NOT NULL,  
	disc float8 NOT NULL,  
	begindate timestamp NOT NULL,  
	end_date timestamp NOT NULL,  
	id_create_user int4 NOT NULL,  
	CONSTRAINT pk_1_discount PRIMARY KEY (id),  
	CONSTRAINT fk_12_discount FOREIGN KEY (id_create_user) REFERENCES tbl.emploee(id)  
);  


-- tbl.receipt definition  

-- Drop table  

-- DROP TABLE tbl.receipt;  

CREATE TABLE tbl.receipt (  
	id int4 NOT NULL,  
	ord_number varchar(50) NOT NULL,  
	id_product int4 NOT NULL,  
	id_discount int4 NOT NULL,  
	sum float8 NULL,  
	sum_nds float8 NULL,  
	amount float8 NULL,  
	CONSTRAINT pk_1_receipt PRIMARY KEY (id),  
	CONSTRAINT receipt_check CHECK ((sum >= (0)::double precision)),  
	CONSTRAINT receipt_check_2 CHECK ((amount >= (0)::double precision)),  
	CONSTRAINT fk_11_receipt FOREIGN KEY (id_discount) REFERENCES tbl.discount(id),  
	CONSTRAINT fk_2_receipt FOREIGN KEY (id_product) REFERENCES tbl.product(id)  
);  
CREATE INDEX receipt_ord_number_idx ON tbl.receipt USING btree (ord_number, id_product, id_discount);  


-- tbl.shop definition  

-- Drop table  

-- DROP TABLE tbl.shop;  

CREATE TABLE tbl.shop (  
	id int4 NOT NULL,  
	"name" varchar(50) NOT NULL,  
	coor varchar(50) NOT NULL,  
	id_manager int4 NOT NULL,  
	phone varchar(50) NOT NULL,  
	open_time timestamp NOT NULL,  
	close_time timestamp NOT NULL,  
	id_city int4 NOT NULL,  
	CONSTRAINT pk_1_shop PRIMARY KEY (id),  
	CONSTRAINT fk_7_shop FOREIGN KEY (id_manager) REFERENCES tbl.emploee(id)  
);  


-- tbl.type_sell definition  

-- Drop table  

-- DROP TABLE tbl.type_sell;  

CREATE TABLE tbl.type_sell (  
	id int4 NOT NULL,  
	"name" varchar(50) NOT NULL,  
	amount float8 NULL,  
	id_sotr_cd int4 NULL,  
	begin_time timestamp NULL,  
	end_time timestamp NULL,  
	is_active int4 NULL,  
	CONSTRAINT pk_1_type_sell PRIMARY KEY (id),  
	CONSTRAINT fk_10_type_sell FOREIGN KEY (id_sotr_cd) REFERENCES tbl.emploee(id)  
);  


-- tbl."transaction" definition  

-- Drop table  

-- DROP TABLE tbl."transaction";  

CREATE TABLE tbl."transaction" (  
	id int4 NOT NULL,  
	id_customer int4 NOT NULL,  
	id_type_sell int4 NOT NULL,  
	id_receipt int4 NOT NULL,  
	is_cash int4 NOT NULL,  
	begin_time timestamp NOT NULL,  
	end_time timestamp NOT NULL,  
	id_delivery int4 NULL,  
	id_shop int4 NOT NULL,  
	id_cashier int4 NOT NULL,  
	CONSTRAINT pk_1_transaction PRIMARY KEY (id),  
	CONSTRAINT fk_1_transaction FOREIGN KEY (id_receipt) REFERENCES tbl.receipt(id),  
	CONSTRAINT fk_3_transaction FOREIGN KEY (id_delivery) REFERENCES tbl.delivery(id),  
	CONSTRAINT fk_4_transaction FOREIGN KEY (id_type_sell) REFERENCES tbl.type_sell(id),  
	CONSTRAINT fk_5_transaction FOREIGN KEY (id_shop) REFERENCES tbl.shop(id),  
	CONSTRAINT fk_6_transaction FOREIGN KEY (id_customer) REFERENCES tbl.customer(id),  
	CONSTRAINT fk_9_transaction FOREIGN KEY (id_cashier) REFERENCES tbl.emploee(id)  
);  

drop table tbl.transaction;
drop table tbl.receipt;
drop table tbl.delivery;
drop table tbl.discount;
drop table tbl.type_sell;
drop table tbl.shop;
drop table tbl.product;
drop table tbl.emploee;
drop table tbl.customer;










CREATE TABLE tbl.customer
(
 id        int NOT NULL,
 name      varchar(50) NOT NULL,
 phone     varchar(50) NOT NULL,
 last_name varchar(50) NOT NULL,
 sex       varchar(50) NOT NULL,
 birthday  timestamp NOT NULL,
 address   varchar(50) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( id )
);


CREATE TABLE tbl.emploee
(
 id          int NOT NULL,
 name        varchar(50) NOT NULL,
 lastname    varchar(50) NOT NULL,
 phone       varchar(50) NOT NULL,
 description varchar(50) NOT NULL,
 is_work     int NOT NULL,
 CONSTRAINT PK_1_emploee PRIMARY KEY ( id )
);

CREATE TABLE tbl.product
(
 id          int NOT NULL,
 name        varchar(50) NOT NULL,
 weight      float,
 height      float,
 lenght      float,
 id_group1   int,
 id_group2   int,
 description varchar(50),
 img_http    varchar(50),
 CONSTRAINT PK_1_product PRIMARY KEY ( id )
);

CREATE TABLE tbl.shop
(
 id         int NOT NULL,
 name       varchar(50) NOT NULL,
 coor       varchar(50) NOT NULL,
 id_manager int NOT NULL,
 phone      varchar(50) NOT NULL,
 open_time  timestamp NOT NULL,
 close_time timestamp NOT NULL,
 id_city    int NOT NULL,
 CONSTRAINT PK_1_shop PRIMARY KEY ( id ),
 CONSTRAINT FK_7_shop FOREIGN KEY ( id_manager ) REFERENCES tbl.emploee ( id )
);


CREATE TABLE tbl.type_sell
(
 id         int NOT NULL,
 name       varchar(50) NOT NULL,
 amount     float,
 id_sotr_cd int,
 begin_time timestamp,
 end_time   timestamp,
 is_active  int,
 CONSTRAINT PK_1_type_sell PRIMARY KEY ( id ),
 CONSTRAINT FK_10_type_sell FOREIGN KEY ( id_sotr_cd ) REFERENCES tbl.emploee ( id )
);

CREATE TABLE tbl.discount
(
 id             int NOT NULL,
 name           varchar(50) NOT NULL,
 amount         float NOT NULL,
 disc           float NOT NULL,
 begindate      timestamp NOT NULL,
 end_date       timestamp NOT NULL,
 id_create_user int NOT NULL,
 CONSTRAINT PK_1_discount PRIMARY KEY ( id ),
 CONSTRAINT FK_12_discount FOREIGN KEY ( id_create_user ) REFERENCES tbl.emploee ( id )
);

CREATE TABLE tbl.delivery
(
 id           int NOT NULL,
 delivery_ord varchar(50),
 id_sotr      int,
 begin_time   timestamp,
 end_time     timestamp,
 coord        varchar(50),
 CONSTRAINT PK_1_delivery PRIMARY KEY ( id ),
 CONSTRAINT FK_8_delivery FOREIGN KEY ( id_sotr ) REFERENCES tbl.emploee ( id )
);

CREATE TABLE tbl.receipt
(
 id          int NOT NULL,
 ord_number  varchar(50) NOT NULL,
 id_product  int NOT NULL,
 id_discount int NOT NULL,
 sum         float,
 sum_nds     float,
 amount      float,
 CONSTRAINT PK_1_receipt PRIMARY KEY ( id ),
 CONSTRAINT FK_11_receipt FOREIGN KEY ( id_discount ) REFERENCES tbl.discount ( id ),
 CONSTRAINT FK_2_receipt FOREIGN KEY ( id_product ) REFERENCES tbl.product ( id )
 
 );


 CREATE TABLE tbl.transaction
(
 id           int NOT NULL,
 id_customer  int NOT NULL,
 id_type_sell int NOT NULL,
 id_receipt   int NOT NULL,
 is_cash      int NOT NULL,
 begin_time   timestamp NOT NULL,
 end_time     timestamp NOT NULL,
 id_delivery  int,
 id_shop      int NOT NULL,
 id_cashier   int NOT NULL,
 CONSTRAINT PK_1_transaction PRIMARY KEY ( id ),
 CONSTRAINT FK_1_transaction FOREIGN KEY ( id_receipt ) REFERENCES tbl.receipt ( id ),
 CONSTRAINT FK_3_transaction FOREIGN KEY ( id_delivery ) REFERENCES tbl.delivery ( id ),
 CONSTRAINT FK_4_transaction FOREIGN KEY ( id_type_sell ) REFERENCES tbl.type_sell ( id ),
 CONSTRAINT FK_5_transaction FOREIGN KEY ( id_shop ) REFERENCES tbl.shop ( id ),
 CONSTRAINT FK_6_transaction FOREIGN KEY ( id_customer ) REFERENCES tbl.customer ( id ),
 CONSTRAINT FK_9_transaction FOREIGN KEY ( id_cashier ) REFERENCES tbl.emploee ( id )
);
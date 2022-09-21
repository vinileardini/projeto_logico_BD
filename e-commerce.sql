-- criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;


-- cliente

create table clients(
	idClient int auto_increment primary key,
    Fname varchar (10),
    Minit char (3),
    Lname varchar (20),
    CPF char(11) not null,
    Adress varchar (30),
    constraint unique_cpf_client unique (CPF)
);

alter table clients auto_increment=1;
alter table clients modify Adress varchar (255);


desc clients;

-- produto

-- size = dimensão do produto

create table product(
	idProduct int auto_increment primary key,
    Pname varchar (10) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
    avaliação float default 0,
    size varchar(10)
);

alter table product modify Pname varchar (50) not null;

-- criar tabelo pagamento, continuar no desafio, continuar a tabela, criar conexões, refletir no esquema (diagrama)

create table payments(
	idClient int,
    id_payment int,
    typePayment enum('Cartão','Boleto','Dois cartões'),
    limitAvailable float,
    primary key (idClient, id_payment)
);

-- pedido

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum ('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar (255),
    shipping float default 0,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients (idClient)
		on update cascade
);



desc orders;

-- estoque

create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar (255),
    quantity int default 0
);

-- fornecedor

create table supplier (
	idSupplier int auto_increment primary key,
    SocialName varchar (255) not null,
    CNPJ char (15) not null unique,
    contact char (11) not null

);

desc supplier;

-- vendedor 

create table seller (
	idSeller int auto_increment primary key,
    SocialName varchar (255) not null,
    AbstName varchar (255),
    CNPJ char (15) not null unique,
    CPF char (9) unique,
    location varchar (255),
    contact char (11) not null
);

create table productSeller (
	idPSeller int,
    idPProduct int,
    prodQuantity int not null,
    primary key (idPSeller, idPProduct),
    constraint fk_product_seller foreign key (idPSeller) references seller (idSeller),
    constraint fk_product_product foreign key (idPProduct) references product (idProduct)
    
);

desc productSeller;

create table productOrder(
	idPOProduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum ('Disponível','Sem estoque') default 'Disponível',
    primary key (idPOProduct,idPOorder),
    constraint fk_productorder_seller foreign key (idPOProduct) references product (idProduct),
    constraint fk_productorder_product foreign key (idPOProduct) references orders (idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar (255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage) 
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier,idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

-- inserção de dados e queries

use ecommerce;

show tables;

insert into clients(Fname, Minit, Lname,CPF, Adress)
		values ('Maria','M','Silva','123456789','rua silva de prata, Carangola - Cidade das flores'),
			   ('Matheus','O','Pimentel','987654321','rua alameda 289, Centro - Cidade das flores'),
               ('Ricardo','F','Silva','456789123','avenida alameda vinha 1009, Centro - Cidade das flores'),
               ('Julia','S','França','789123456','lareijras 861, Centro - Cidade das flores'),
               ('Roberta','G','Assis','98745631','avenida koller 19, Centro - Cidade das flores'),
               ('Isabela','M','Cruz','654789123','rua alameda das flores, Centro - Cidade das flores');
               

insert into product (Pname, classification_kids, category, avaliação, size)
		values ('Fone de ouvido',false, 'Eletrônico','4',null),
			   ('Barbie Elsa',true,'Brinquedos','3',null),
               ('Body Carters',true,'Vestimenta','5',null),
               ('Microfone Vedo - Youtuber',false,'Eletrônico','4',null),
               ('Sofá retrátil',false,'Móveis','3','3x57x80'),
               ('Farinha de arroz',false,'Alimentos','2',null),
               ('Fire Stick Amazon',false,'Eletrônico','3',null);
               

select * from clients;
select * from product; 

insert into orders(idOrderClient, orderStatus, orderDescription, shipping, paymentCash)
		values (1,null,'compra via aplicativo',null,1),
			   (2,null,'compra via aplicativo',50,0),
               (3,'Confirmado',null,null,1),
               (4,null,'compra via web site',150,0);

select * from orders;



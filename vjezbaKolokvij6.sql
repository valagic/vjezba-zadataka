drop database if exists vjezbaKolokvij6;
create database vjezbaKolokvij6;
use vjezbaKolokvij6;

create table prijatelj(
	sifra int not null primary key auto_increment,
	haljina varchar(50),
	prstena int not null,
	introventno bit,
	stilfrizura varchar(50) not null
);

create table svekrva(
	sifra int not null primary key auto_increment,
	hlace varchar(50) not null,
	suknja varchar(50) not null,
	ogrlica int not null,
	treciputa datetime not null,
	dukserica varchar(50) not null,
	narukvica int not null,
	punac int
);

create table brat(
	sifra int not null primary key auto_increment,
	nausnica int not null,
	treciputa datetime not null,
	narukvica int not null,
	hlace varchar(50),
	prijatelj int
);

create table prijatelj_ostavljena(
	sifra int not null primary key auto_increment,
	prijatelj int not null,
	ostavljena int not null
);

create table punac(
	sifra int not null primary key auto_increment,
	ekstroventno bit not null,
	suknja varchar(50) not null,
	majica varchar(50) not null,
	prviputa datetime not null
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	prviputa datetime not null,
	kratkamajica varchar(50) not null,
	drugiputa datetime,
	maraka decimal(10,10)
);

create table zena(
	sifra int not null primary key auto_increment,
	novcica decimal(10,10) not null,
	narukvica int not null,
	dukserica varchar(50) not null,
	haljina varchar(50),
	hlace varchar(50),
	brat int not null
);

create table decko(
	sifra int not null primary key auto_increment,
	prviputa datetime,
	modelnaocala varchar(50),
	nausnica int,
	zena int not null
);

alter table svekrva add foreign key(punac) references punac(sifra);
alter table brat add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key(ostavljena) references ostavljena(sifra);
alter table zena add foreign key(brat) references brat(sifra);
alter table decko add foreign key(zena) references zena(sifra);

#U tablice zena, brat i prijatelj_ostavljena unesite po 3 retka. 

insert into prijatelj(prstena,stilfrizura) values
(10,'plava');
insert into ostavljena(prviputa,kratkamajica) values
('2021-06-06','plava');
insert into prijatelj_ostavljena(prijatelj,ostavljena) values
(1,1),
(1,1),
(1,1);
insert into brat(nausnica,treciputa,narukvica) values
(20,'2021-04-04',20),
(10,'2021-05-05',10),
(30,'2021-06-06',30);
insert into zena(novcica,narukvica,dukserica,brat) values
(0.10,10,'plava',1),
(0.20,20,'crvena',1),
(0.30,30,'zuta',1);



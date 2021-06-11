drop database if exists vjezbaKolokvij9;
create database vjezbaKolokvij9;
use vjezbaKolokvij9;

create table punac_prijateljica(
	sifra int not null primary key auto_increment,
	punac int not null,
	prijateljica int not null
);

create table prijateljica(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	novcica decimal(20,10),
	kuna decimal(20,10) not null,
	drugiputa datetime,
	haljina varchar(50),
	kratkamajica varchar(50)
);

create table cura(
	sifra int not null primary key auto_increment,
	vesta varchar(50) not null,
	ekstroventno bit,
	carape varchar(50),
	suknja varchar(50) not null,
	punac int not null
);

create table punac(
	sifra int not null primary key auto_increment,
	narukvica int not null,
	modelnaocala varchar(50),
	kuna decimal(20,10),
	bojaociju varchar(60),
	suknja varchar(50)
);

create table zarucnik(
	sifra int not null primary key auto_increment,
	gustoca decimal(20,10),
	haljina varchar(50),
	kratkamajica varchar(50) not null,
	nausnica int not null,
	brat int not null
);

create table brat(
	sifra int not null primary key auto_increment,
	novcica decimal(20,10) not null,
	ekstroventno bit,
	vesta varchar(50) not null,
	cura int
);

create table snasa(
	sifra int not null primary key auto_increment,
	prstena int,
	drugiputa datetime not null,
	haljina varchar(60) not null,
	ostavljena int
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	modelnaocala varchar(87) not null,
	suknja varchar(50),
	eura decimal(20,10) not null,
	lipa decimal(20,10) not null,
	treciputa datetime not null,
	drugiputa datetime not null
);
drop database if exists vjezbaKolokvij4;
create database vjezbaKolokvij4;
use vjezbaKolokvij4;

create table punac (
	sifra int not null primary key auto_increment,
	treciputa datetime,
	majica varchar(46),
	jmbg char(11) not null,
	novcica decimal(18,7) not null,
	maraka decimal(12,6) not null,
	ostavljen int not null
);

create table ostavljen (
	sifra int not null primary key auto_increment,
	modelnaocala varchar(43),
	introventno bit,
	kuna decimal(14,10)
);

create table snasa (
	sifra int not null primary key auto_increment,
	introventno bit,
	treciputa datetime,
	haljina varchar(44) not null,
	zena int not null
);

create table zena (
	sifra int not null primary key auto_increment,
	suknja varchar(39) not null,
	lika decimal(18,7),
	prstena int not null
);

create table zena_mladic (
	sifra int not null primary key auto_increment,
	zena int not null,
	mladic int not null
);

create table becar (
	sifra int not null primary key auto_increment,
	novcica decimal(14,8),
	kratkamajica varchar(48) not null,
	bojaociju varchar(36) not null,
	snasa int not null
);

create table mladic (
	sifra int not null primary key auto_increment,
	kuna decimal(15,9),
	lipa decimal(18,5),
	nausnica int,
	stilfrizura varchar(49),
	vesta varchar(34) not null
);

create table prijatelj (
	sifra int not null primary key auto_increment,
	eura decimal(16,9),
	prstena int not null,
	gustoca  decimal(16,5),
	jmbg char(11) not null,
	suknja varchar(47) not null,
	becar int not null
);


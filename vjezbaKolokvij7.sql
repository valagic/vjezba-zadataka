drop database if exists vjezbaKolokvij7;
create database vjezbaKolokvij7;
use vjezbaKolokvij7;

create table zarucnik_mladic(
	sifra int not null primary key auto_increment,
	zarucnik int not null,
	mladic int not null
);

create table mladic(
	sifra int not null primary key auto_increment,
	prstena int,
	lipa decimal(20,10) not null,
	narukvica int not null,
	drugiputa datetime not null
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	lipa decimal(20,10),
	instroventno bit not null,
	kratkamajica varchar(50) not null,
	prstena int not null,
	zarucnik int
);

create table zarucnik(
	sifra int not null primary key auto_increment,
	vesta varchar(50),
	asocijalno bit not null,
	modelnaocala varchar(50),
	narukvica int not null,
	novcica decimal(20,10) not null
);

create table sestra(
	sifra int not null primary key auto_increment,
	bojakose varchar(50) not null,
	hlace varchar(50) not null,
	lipa decimal(20,10),
	stilfrizura varchar(50) not null,
	maraka decimal(20,10) not null,
	prijateljica int
);

create table prijateljica(
	sifra int not null primary key auto_increment,
	haljina varchar(50),
	gustoca decimal(20,10) not null,
	orgrlica int,
	novcica decimal(20,10),
	ostavljena int
);

create table punica(
	sifra int not null primary key auto_increment,
	majica varchar(40),
	eura decimal(20,10) not null,
	prstena int,
	cura int not null
);

create table cura(
	sifra int not null primary key auto_increment,
	lipa decimal(20,10) not null,
	introventno bit,
	modelnaocala varchar(50),
	narukvica int,
	treciputa datetime,
	kuna decimal(20,10)
);


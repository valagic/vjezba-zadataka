drop database if exists vjezbaKolokvij8;
create database vjezbaKolokvij8;
use vjezbaKolokvij8;

create table prijateljica (
	sifra int not null primary key auto_increment,
	vesta varchar(50),
	nausnica int not null,
	introventno int not null
);

create table cura (
	sifra int not null primary key auto_increment,
	nausnica int not null,
	indiferentno bit,
	ogrlica int not null,
	gustoca decimal(50,10),
	drugiputa datetime,
	vesta varchar(50),
	prijateljica int
);

create table neprijatelj (
	sifra int not null primary key auto_increment,
	kratkamajica varchar(50),
	introventno bit,
	indiferentno bit,
	ogrlica int not null,
	becar int not null
);

create table becar (
	sifra int not null primary key auto_increment,
	eura decimal(50,10) not null,
	treciputa datetime,
	prviputa datetime,
	muskarac int not null
);

create table muskarac (
	sifra int not null primary key auto_increment,
	haljina varchar(50),
	drugiputa datetime not null,
	treciputa datetime
);

create table muskarac_decko (
	sifra int not null primary key auto_increment,
	muskarac int not null,
	decko int not null
);

create table brat (
	sifra int not null primary key auto_increment,
	introventno bit,
	novcica decimal(50,10) not null,
	treciputa datetime,
	neprijatelj int
);

create table decko (
	sifra int not null primary key auto_increment,
	kuna decimal (50,10),
	lipa decimal (50,10),
	bojakose varchar(50),
	treciputa datetime not null,
	ogrlica int not null,
	ekstroventno bit not null
);

alter table cura add foreign key(prijateljica) references prijateljica(sifra);
alter table neprijatelj add foreign key(becar) references becar(sifra);
alter table becar add foreign key(muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key(muskarac) references muskarac(sifra);
alter table muskarac_decko add foreign key(decko) references decko(sifra);
alter table brat add foreign key(neprijatelj) references neprijatelj(sifra);


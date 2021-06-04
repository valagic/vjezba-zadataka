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

/*1. U tablice neprijatelj, becar i muskarac_decko unesite po 3 retka*/

insert into decko(treciputa,ogrlica,ekstroventno) values
('2021-05-05',1,1);
insert into muskarac(drugiputa) values
('2021-05-06');
insert into muskarac_decko(muskarac,decko) values
(1,1),
(1,1),
(1,1);
insert into becar(eura,muskarac) values
(55.67,1),
(11.45,1),
(104.56,1);
insert into neprijatelj(ogrlica,becar) values
(1,1),
(1,1),
(1,1);

/*U tablici cura postavite svim zapisima kolonu indiferentno na 
vrijednost false*/

update cura set indiferentno=false;

/*U tablici brat obrišite sve zapise čija je vrijednost kolone novcica 
različito od 12,75. (*/

insert into brat(novcica) values
(12.75),
(22.22),
(8.54);
select * from brat;
delete from brat where novcica != 12.75;

/*Izlistajte prviputa iz tablice becar uz uvjet da vrijednost kolone 
treciputa nepoznate.*/

select * from becar where treciputa is null;

/*Prikažite bojakose iz tablice decko, neprijatelj iz tablice brat te 
introvertno iz tablice neprijatelj uz uvjet da su vrijednosti kolone 
treciputa iz tablice becar poznate te da su vrijednosti kolone 
drugiputa iz tablice muskarac poznate. Podatke posložite po 
introvertno iz tablice neprijatelj silazno. */

select a.bojakose , f.neprijatelj , e.introventno 
from decko a inner join muskarac_decko b on a.sifra = b.decko 
inner join muskarac c on c.sifra = b.muskarac 
inner join becar d on c.sifra = d.muskarac 
inner join neprijatelj e on e.becar = d.sifra 
inner join brat f on f.neprijatelj = e.sifra 
where d.treciputa is not null and c.drugiputa is not null 
order by e.indiferentno desc;

/*Prikažite kolone drugiputa i treciputa iz tablice muskarac čiji se 
primarni ključ ne nalaze u tablici muskarac_decko.*/

select c.drugiputa, c.treciputa 
from muskarac c
where not exists (select * from  muskarac_decko b where b.muskarac =c.sifra);

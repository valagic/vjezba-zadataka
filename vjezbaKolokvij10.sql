drop database if exists vjezbaKolokvij10;
create database vjezbaKolokvij10;
use vjezbaKolokvij10;

create table zarucnica(
	sifra int not null primary key auto_increment,
	treciputa datetime,
	prviputa datetime,
	suknja varchar(50) not null,
	eura decimal(20,10)
);

create table sestra(
	sifra int not null primary key auto_increment,
	suknja varchar(50) not null,
	bojaociju varchar(50),
	indiferentno bit,
	dukserica varchar(50) not null,
	drugiputa datetime,
	prviputa datetime not null,
	zarucnica int
);

create table svekrva(
	sifra int not null primary key auto_increment,
	eura decimal(20,10),
	carape varchar(50),
	kuna decimal(20,10),
	majica varchar(50),
	introventno bit not null,
	punac int
);

create table punac(
	sifra int not null primary key auto_increment,
	lipa decimal(20,10),
	eura decimal(20,10) not null,
	stilfrizura varchar(50)
);

create table punac_neprijatelj(
	sifra int not null primary key auto_increment,
	punac int not null,
	neprijatelj int not null
);

create table neprijatelj(
	sifra int not null primary key auto_increment,
	gustoca decimal(20,10) not null,
	dukserica varchar(50) not null,
	maraka decimal(20,10),
	stilfrizura varchar(50) not null
);

create table zena(
	sifra int not null primary key auto_increment,
	bojaociju varchar(50) not null,
	maraka decimal(20,10) not null,
	majica varchar(50),
	indiferentno bit,
	prviputa datetime,
	mladic int
);

create table mladic(
	sifra int not null primary key auto_increment,
	hlace varchar(50) not null,
	lipa decimal(20,10),
	stilfrizura varchar(50) not null,
	prstena int,
	maraka decimal(20,10) not null,
	svekrva int
);

alter table sestra add foreign key(zarucnica) references zarucnica(sifra);
alter table svekrva add foreign key(punac) references punac(sifra);
alter table punac_neprijatelj add foreign key(punac) references punac(sifra);
alter table punac_neprijatelj add foreign key(neprijatelj) references neprijatelj(sifra);
alter table mladic add foreign key(svekrva) references svekrva(sifra);
alter table zena add foreign key(mladic) references mladic(sifra);

/*U tablice mladic, svekrva i punac_neprijatelj unesite po 3 retka.*/

insert into punac(eura) values
(22.22);
insert into svekrva(introventno) values
(1);
insert into mladic(hlace,stilfrizura,maraka) values
('plave','plava',2.2),
('zuta','zuta',3.2),
('crvena','crvena',4.2);
insert into neprijatelj (gustoca,dukserica,stilfrizura) values
(2.2,'plava','plava');
insert into punac_neprijatelj (punac,neprijatelj) values
(1,1),
(1,1),
(1,1);

/* U tablici sestra postavite svim zapisima kolonu bojaociju na 
vrijednost Osijek */

update sestra set bojaociju = 'Osijek';

/* U tablici zena obrišite sve zapise čija je vrijednost kolone maraka 
različito od 14,81*/

delete from zena where maraka = 14.81;

/* Izlistajte kuna iz tablice svekrva uz uvjet da vrijednost kolone 
carape sadrže slova ana.  */

select kuna from svekrva where carape like '%ana%';

/*  Prikažite maraka iz tablice neprijatelj, indiferentno iz tablice zena 
te lipa iz tablice mladic uz uvjet da su vrijednosti kolone carape iz 
tablice svekrva počinju slovom a te da su vrijednosti kolone eura iz 
tablice punac različite od 22. Podatke posložite po lipa iz tablice 
mladic silazno. (10) */

select a.maraka , f.indiferentno ,e.lipa 
from neprijatelj a inner join punac_neprijatelj b on a.sifra = b.neprijatelj 
inner join punac c on b.punac = c.sifra 
inner join svekrva d on d.punac = c.sifra 
inner join mladic e on e.svekrva = d.sifra 
inner join zena f on f.mladic = e.sifra 
where d.carape like 'a%' and c.eura !=22
order by e.lipa desc;

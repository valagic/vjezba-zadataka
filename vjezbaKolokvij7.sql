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

create table ostavljen(
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
	ostavljen int
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

alter table zarucnik_mladic add foreign key(mladic) references mladic(sifra);
alter table zarucnik_mladic add foreign key(zarucnik) references zarucnik(sifra);
alter table ostavljen add foreign key(zarucnik) references zarucnik(sifra);
alter table prijateljica add foreign key(ostavljen) references ostavljen(sifra);
alter table sestra add foreign key(prijateljica) references prijateljica(sifra);
alter table punica add foreign key(cura) references cura(sifra);

/*U tablice prijateljica, ostavljen i zarucnik_mladic unesite po 3 
retka. */

insert into mladic(lipa,narukvica,drugiputa) values
(55.55,5,'2021-05-05');
insert into zarucnik(asocijalno,narukvica,novcica) values
(1,1,44.44);
insert into zarucnik_mladic(zarucnik,mladic) values
(1,1),
(1,1),
(1,1);
insert into ostavljen(instroventno,kratkamajica,prstena) values
(1,'plava',1),
(1,'crvena',1),
(1,'zuta',1);
insert into prijateljica(gustoca) values
(33.33),
(44.44),
(11.11);

/*U tablici punica postavite svim zapisima kolonu eura na vrijednost 
15,77.*/

update punica set eura=15.77;

/*U tablici sestra obrišite sve zapise čija je vrijednost kolone hlace 
manje od AB(15).*/
delete from sestra where hlace>'AB';
delete from sestra where hlace>15;


/*Izlistajte kratkamajica iz tablice ostavljen uz uvjet da vrijednost 
kolone introvertno nepoznate.*/

select kratkamajica from ostavljen where instroventno is null;

/*Prikažite narukvica iz tablice mladic, stilfrizura iz tablice sestra te 
gustoca iz tablice prijateljica uz uvjet da su vrijednosti kolone 
introvertno iz tablice ostavljen poznate te da su vrijednosti kolone 
asocijalno iz tablice zarucnik poznate. Podatke posložite po gustoca iz 
tablice prijateljica silazno.*/

select a.narukvica , f.stilfrizura , e.gustoca 
from zarucnik_mladic b inner join mladic a on b.mladic =a.sifra 
inner join zarucnik c on b.zarucnik = c.sifra 
inner join ostavljen d on d.zarucnik = c.sifra 
inner join prijateljica e on e.ostavljen  = d.sifra 
inner join sestra f on f.prijateljica  = e.sifra 
where d.instroventno is not null and c.asocijalno is not null 
order by e.gustoca desc;

/*Prikažite kolone asocijalno i modelnaocala iz tablice zarucnik čiji se 
primarni ključ ne nalaze u tablici zarucnik_mladic.*/

select c.asocijalno , c.modelnaocala 
from zarucnik c
where not exists (select * from  zarucnik_mladic b where b.zarucnik =c.sifra);


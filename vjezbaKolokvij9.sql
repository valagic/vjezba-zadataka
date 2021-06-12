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

alter table punac_prijateljica add foreign key(prijateljica) references prijateljica(sifra);
alter table punac_prijateljica add foreign key(punac) references punac(sifra);
alter table cura add foreign key (punac) references punac(sifra);
alter table brat add foreign key(cura) references cura(sifra);
alter table zarucnik add foreign key(brat) references brat(sifra);
alter table snasa add foreign key(ostavljena) references ostavljena(sifra);


/*U tablice brat, cura i punac_prijateljica unesite po 3 retka. */

insert into prijateljica(kuna) values
(5.55);
insert into punac(narukvica) values
(1);
insert into punac_prijateljica(punac,prijateljica) values
(1,1),
(1,1),
(1,1);
insert into cura(vesta,suknja,punac) values
('plava','plava',1),
('zuta','zuta',1),
('crna','crna',1);
insert into brat(novcica,vesta) values
(5.55,'plava'),
(20.55,'zuta'),
(100.55,'crna');

/* U tablici snasa postavite svim zapisima kolonu drugiputa na 
vrijednost 24. travnja 2020.*/

select * from snasa;
update snasa set drugiputa='2020-04-24';

/*U tablici zarucnik obrišite sve zapise čija je vrijednost kolone 
haljina jednako AB.*/
 
select * from zarucnik;
delete from zarucnik where haljina='AB';

/* Izlistajte carape iz tablice cura uz uvjet da vrijednost kolone 
ekstroventno nepoznate. */

select carape from cura where ekstroventno is null;

/*Prikažite kuna iz tablice prijateljica, nausnica iz tablice zarucnik te 
ekstroventno iz tablice brat uz uvjet da su vrijednosti kolone 
ekstroventno iz tablice cura poznate te da su vrijednosti kolone 
modelnaocala iz tablice punac sadrže niz znakova ba. Podatke 
posložite po ekstroventno iz tablice brat silazno*/

select a.kuna , f.nausnica , e.ekstroventno 
from prijateljica a inner join punac_prijateljica b on a.sifra = b.prijateljica 
inner join punac c on b.punac = c.sifra 
inner join cura d on d.punac = c.sifra 
inner join brat e on e.cura = d.sifra 
inner join zarucnik f on f.brat = e.sifra 
where d.ekstroventno is not null and c.modelnaocala like '%ba%'
order by e.ekstroventno desc;

/*Prikažite kolone modelnaocala i kuna iz tablice punac čiji se 
primarni ključ ne nalaze u tablici punac_prijateljica. */

select c.modelnaocala , c.kuna 
from punac c
where not exists (select * from  punac_prijateljica b where b.punac =c.sifra);

drop database if exists vjezbakolokvij3;
create database vjezbakolokvij3;
use vjezbakolokvij3;

create table svekar(
	sifra int not null primary key auto_increment,
	novcica decimal(16,8) not null,
	suknja varchar(44) not null,
	bojakose varchar(36),
	prstena int,
	narukvica int not null,
	cura int not null
);

create table ostavljena (
	sifra int not null primary key auto_increment,
	kuna decimal(17,5),
	lipa decimal(15,6),
	majica varchar(36),
	modelnaocala varchar(31) not null,
	prijatelj int
);

create table cura(
	sifra int not null primary key auto_increment,
	dukserica varchar(49),
	maraka decimal(13,7),
	drugiputa datetime,
	majica varchar(49),
	novcica decimal(15,8),
	ogrlica int not null
);

create table prijatelj(
	sifra int not null primary key auto_increment,
	kuna decimal(16,10),
	haljina varchar(37),
	lipa decimal(13,10),
	dukserica varchar(31),
	indiferentno bit not null	
);

create table snasa(
	sifra int not null primary key auto_increment,
	introventno bit,
	kuna decimal(15,6) not null,
	eura decimal(12,9) not null,
	treciputa datetime,
	ostavljena int not null
);

create table prijatelj_brat(
	sifra int not null primary key auto_increment,
	prijatelj int not null,
	brat int not null
);

create table punica(
	sifra int not null primary key auto_increment,
	asocijalno bit,
	kratkamajica varchar(44),
	kuna decimal(13,8) not null,
	vesta varchar(32) not null,
	snasa int
);

create table brat(
	sifra int not null primary key auto_increment,
	jmbg char(11),
	ogrlica int not null,
	ekstroventno bit not null
);

alter table svekar add foreign key(cura) references cura(sifra);
alter table snasa add foreign key(ostavljena) references ostavljena(sifra);
alter table ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_brat add foreign key(prijatelj) references prijatelj(sifra);

alter table punica add foreign key(snasa) references snasa(sifra);
alter table prijatelj_brat add foreign key(brat) references brat(sifra);

#U tablice snasa, ostavljena i prijatelj_brat unesite po 3 retka.
insert into prijatelj(indiferentno) values
(1);
insert into ostavljena(modelnaocala) values
('suzuki');
insert into snasa(kuna,eura,ostavljena) values
(54.43,67.45,1);
insert into brat(ogrlica,ekstroventno) values
(1,1);
insert into prijatelj_brat(prijatelj,brat) values
(1,1);

select * from prijatelj;
select * from ostavljena;
select * from snasa;
select * from brat;
select * from prijatelj_brat;

#U tablici svekar postavite svim zapisima kolonu suknja na 
#vrijednost Osijek

insert into cura(ogrlica) values
(1);
insert into svekar(novcica,suknja,narukvica,cura) values
(67.67,'bijela',1,1);
select * from svekar;

update svekar set suknja='Osijek';

#U tablici punica obri??ite sve zapise ??ija je vrijednost kolone 
#kratkamajica jednako AB.

insert into ostavljena(modelnaocala) values
('suzuki');
insert into snasa(kuna,eura,ostavljena) values
(55.44,88.77,1);
insert into punica(kuna,vesta) values
(124.56,'dugacka');
select * from punica;

delete from punica where kratkamajica='AB';

#Izlistajte majica iz tablice ostavljena uz uvjet da vrijednost kolone 
#lipa nije 9,10,20,30 ili 35.
insert into prijatelj(indiferentno) values
(1);
insert into ostavljena(lipa,modelnaocala) values
(9,'suzuki'),
(14,'suzuki'),
(20,'suzuki'),
(28,'suzuki'),
(30,'suzuki'),
(33,'suzuki'),
(35,'suzuki');
select majica from ostavljena where lipa not in (9,10,20,30,35);

/*Prika??ite ekstroventno iz tablice brat, vesta iz tablice punica te 
kuna iz tablice snasa uz uvjet da su vrijednosti kolone lipa iz tablice 
ostavljena razli??ito od 91 te da su vrijednosti kolone haljina iz tablice 
prijatelj sadr??e niz znakova ba. Podatke poslo??ite po kuna iz tablice 
snasa silazno. */

select a.ekstroventno, f.vesta, e.kuna 
from brat a inner join prijatelj_brat b on b.brat=a.sifra
inner join prijatelj c on b.prijatelj=c.sifra 
inner join ostavljena d on d.prijatelj=c.sifra 
inner join snasa e on e.ostavljena=d.sifra 
inner join punica f on f.snasa=e.sifra 
where d.lipa !=91 and c.haljina like '%ba%';

#Prika??ite kolone haljina i lipa iz tablice prijatelj ??iji se primarni klju?? 
#ne nalaze u tablici prijatelj_brat

select c.haljina, c.lipa 
from prijatelj c
where not exists
(select * from prijatelj_brat b where b.prijatelj = c.sifra);
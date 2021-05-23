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
	lipa decimal(18,7),
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

alter table punac add foreign key(ostavljen) references ostavljen(sifra);
alter table snasa add foreign key(zena) references zena(sifra);
alter table zena_mladic add foreign key(zena) references zena(sifra);
alter table zena_mladic add foreign key(mladic) references mladic(sifra);
alter table becar add foreign key(snasa) references snasa(sifra);
alter table prijatelj add foreign key(becar) references becar(sifra);
 
#U tablice becar, snasa i zena_mladic unesite po 3 retka.
insert into zena(suknja,prstena) values
('crevena',1);

insert into mladic(vesta) values
('crvena');

insert into zena_mladic(zena,mladic) values
(1,1),
(1,1),
(1,1);

insert into snasa(haljina,zena) values
('plava',1),
('crvena',1),
('zuta',1);

insert into becar(kratkamajica,bojaociju,snasa) values
('plava','plava',1),
('zuta','zuta',1),
('crna','crna',1);

 /*U tablici punac postavite svim zapisima kolonu majica na 
vrijednost Osijek*/

insert into ostavljen(kuna) values
(235.23);
insert into punac(jmbg,novcica,maraka,ostavljen) values
(11111111111,55.45,56.78,1);
select * from punac;
update punac set majica='Osijek';

/*. U tablici prijatelj obrišite sve zapise čija je vrijednost kolone 
prstena veće od 17.*/
insert into zena(suknja,prstena) values
('crevena',1);
insert into snasa(haljina,zena) values
('plava',1),
('crvena',1),
('zuta',1);
insert into becar(kratkamajica,bojaociju,snasa) values
('plava','plava',1),
('zuta','zuta',1),
('crna','crna',1);
insert into prijatelj(prstena,jmbg,suknja,becar) values
(4,22222222222,'plava',1),
(24,22222222222,'plava',1),
(8,22222222222,'plava',1),
(45,22222222222,'plava',1),
(88,22222222222,'plava',1);
select * from prijatelj;

delete from prijatelj where prstena >17;

/*4. Izlistajte haljina iz tablice snasa uz uvjet da vrijednost kolone 
treciputa nepoznate.*/

select * from snasa;

select * from snasa where treciputa is null;

/*Prikažite nausnica iz tablice mladic, jmbag iz tablice prijatelj te 
kratkamajica iz tablice becar uz uvjet da su vrijednosti kolone 
treciputa iz tablice snasa poznate te da su vrijednosti kolone lipa iz 
tablice zena različite od 29. Podatke posložite po kratkamajica iz 
tablice becar silazno. */

select e.kratkamajica, f.jmbg , a.nausnica
from mladic a inner join zena_mladic b on b.mladic=a.sifra
inner join zena c on b.zena = c.sifra 
inner join snasa d on c.sifra =d.zena 
inner join becar e on e.snasa = d.sifra 
inner join prijatelj f on e.sifra = f.becar 
where d.treciputa is not null and c.lipa!=29; 

/*. Prikažite kolone lipa i prstena iz tablice zena čiji se primarni ključ 
ne nalaze u tablici zena_mladic. */

select c.lipa, c.prstena 
from zena c
where not exists (select * from  zena_mladic b where b.zena=c.sifra);

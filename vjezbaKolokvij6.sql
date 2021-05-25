drop database if exists vjezbaKolokvij6;
create database vjezbaKolokvij6;
use vjezbaKolokvij6;

create table prijatelj(
	sifra int not null primary key auto_increment,
	haljina varchar(50),
	prstena int not null,
	introventno bit,
	stilfrizura varchar(50) not null
);

create table svekrva(
	sifra int not null primary key auto_increment,
	hlace varchar(50) not null,
	suknja varchar(50) not null,
	ogrlica int not null,
	treciputa datetime not null,
	dukserica varchar(50) not null,
	narukvica int not null,
	punac int
);

create table brat(
	sifra int not null primary key auto_increment,
	nausnica int not null,
	treciputa datetime not null,
	narukvica int not null,
	hlace varchar(50),
	prijatelj int
);

create table prijatelj_ostavljena(
	sifra int not null primary key auto_increment,
	prijatelj int not null,
	ostavljena int not null
);

create table punac(
	sifra int not null primary key auto_increment,
	ekstroventno bit not null,
	suknja varchar(50) not null,
	majica varchar(50) not null,
	prviputa datetime not null
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	prviputa datetime not null,
	kratkamajica varchar(50) not null,
	drugiputa datetime,
	maraka decimal(10,10)
);

create table zena(
	sifra int not null primary key auto_increment,
	novcica decimal(10,10) not null,
	narukvica int not null,
	dukserica varchar(50) not null,
	haljina varchar(50),
	hlace varchar(50),
	brat int not null
);

create table decko(
	sifra int not null primary key auto_increment,
	prviputa datetime,
	modelnaocala varchar(50),
	nausnica int,
	zena int not null
);

alter table svekrva add foreign key(punac) references punac(sifra);
alter table brat add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key(prijatelj) references prijatelj(sifra);
alter table prijatelj_ostavljena add foreign key(ostavljena) references ostavljena(sifra);
alter table zena add foreign key(brat) references brat(sifra);
alter table decko add foreign key(zena) references zena(sifra);

#U tablice zena, brat i prijatelj_ostavljena unesite po 3 retka. 

insert into prijatelj(prstena,stilfrizura) values
(10,'plava');
insert into ostavljena(prviputa,kratkamajica) values
('2021-06-06','plava');
insert into prijatelj_ostavljena(prijatelj,ostavljena) values
(1,1),
(1,1),
(1,1);
insert into brat(nausnica,treciputa,narukvica) values
(20,'2021-04-04',20),
(10,'2021-05-05',10),
(30,'2021-06-06',30);
insert into zena(novcica,narukvica,dukserica,brat) values
(0.10,10,'plava',1),
(0.20,20,'crvena',1),
(0.30,30,'zuta',1);

/*U tablici svekrva postavite svim zapisima kolonu suknja na 
vrijednost Osijek. */
select * from svekrva;
insert into svekrva(hlace,suknja,ogrlica,treciputa,dukserica,narukvica) values
('plave','plava',10,'2021-05-05','plava',10);
update svekrva set suknja='Osijek';

/*U tablici decko obrišite sve zapise čija je vrijednost kolone 
modelnaocala manje od AB(18).*/

select * from decko;
insert into prijatelj(prstena,stilfrizura) values
(10,'plava');
insert into brat(nausnica,treciputa,narukvica) values
(20,'2021-04-04',20),
(10,'2021-05-05',10),
(30,'2021-06-06',30);
insert into zena(novcica,narukvica,dukserica,brat) values
(0.10,10,'plava',1),
(0.20,20,'crvena',1),
(0.30,30,'zuta',1);
insert into decko(zena) values
(1);

delete from decko where modelnaocala<18;

/*Izlistajte narukvica iz tablice brat uz uvjet da vrijednost kolone 
treciputa nepoznate.*/

select * from brat;
select narukvica from brat where treciputa is null;

/*Prikažite drugiputa iz tablice ostavljena, zena iz tablice decko te 
narukvica iz tablice zena uz uvjet da su vrijednosti kolone treciputa iz 
tablice brat poznate te da su vrijednosti kolone prstena iz tablice 
prijatelj jednake broju 219. Podatke posložite po narukvica iz tablice 
zena silazno.*/

select a.drugiputa , f.zena , e.narukvica 
from ostavljena a inner join prijatelj_ostavljena b on b.ostavljena = a.sifra 
inner join prijatelj c on b.prijatelj =c.sifra 
inner join brat d on d.prijatelj =c.sifra 
inner join zena e on e.brat =d.sifra 
inner join decko f on f.zena =e.sifra 
where d.treciputa is not null and c.prstena =219
order by e.novcica DESC;
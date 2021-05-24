drop database if exists vjezbaKolokvij5;
create database vjezbaKolokvij5;
use vjezbaKolokvij5;

create table mladic(
	sifra int not null primary key auto_increment,
	kratkamajica varchar(48) not null,
	haljina varchar(30) not null,
	asocijalno bit,
	zarucnik int
);

create table zarucnik(
	sifra int not null primary key auto_increment,
	jmbg char(11),
	lipa decimal(12,8),
	indiferentno bit not null
);

create table punac(
	sifra int not null primary key auto_increment,
	dukserica varchar(33),
	prviputa datetime not null,
	majica varchar(36),
	svekar int not null
);

create table svekar(
	sifra int not null primary key auto_increment,
	bojakose varchar(33),
	majica varchar(31),
	carape varchar(31) not null,
	haljina varchar(43),
	narukvica int,
	eura decimal(14,5) not null
);

create table svekar_cura(
	sifra int not null primary key auto_increment,
	svekar int not null,
	cura int not null
);

create table cura(
	sifra int not null primary key auto_increment,
	carape varchar(41) not null,
	maraka decimal(17,10) not null,
	asocijalno bit,
	vesta varchar(47) not null
);

create table ostavljena(
	sifra int not null primary key auto_increment,
	majica varchar(33),
	ogrlica int not null,
	carape varchar(44),
	stilfrizura varchar(42),
	punica int not null
);

create table punica(
	sifra int not null primary key auto_increment,
	hlace varchar(43) not null,
	nausnica int not null,
	ogrlica int,
	vesta varchar(49) not null,
	modelnaocala varchar(31) not null,
	treciputa datetime not null,
	punac int not null
);

alter table mladic add foreign key(zarucnik) references zarucnik(sifra);
alter table punac add foreign key(svekar) references svekar(sifra);
alter table svekar_cura add foreign key(svekar) references svekar(sifra);
alter table svekar_cura add foreign key(cura) references cura(sifra);
alter table punica add foreign key(punac) references punac(sifra);
alter table ostavljena add foreign key(punica) references punica(sifra);

# U tablice punica, punac i svekar_cura unesite po 3 retka.

insert into svekar(carape,eura) values
('plave',15.55);
insert into punac(prviputa,svekar) values
('2021-05-05',1),
('2021-06-06',1),
('2021-04-04',1);
insert into cura(carape,maraka,vesta) values
('plave',55.67,'plava');
insert into svekar_cura(svekar,cura) values
(1,1),
(1,1),
(1,1);
insert into punica(hlace,nausnica,vesta,modelnaocala,treciputa,punac) values
('plave',1,'plava','plave','2021-05-05',1),
('zute',1,'zuta','zuta','2021-06-05',1),
('crna',1,'crna','crne','2021-04-05',1);
insert into ostavljena(ogrlica,punica) values
(1,1);

/* U tablici mladic postavite svim zapisima kolonu haljina na 
vrijednost Osijek.*/

select * from mladic;
update mladic set haljina='Osijek';

/*U tablici ostavljena obrišite sve zapise čija je vrijednost kolone 
ogrlica jednako 17*/

select * from ostavljena;
delete from ostavljena where ogrlica=17;
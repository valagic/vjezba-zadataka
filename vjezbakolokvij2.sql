drop database if exists vjezba2;
create database vjezba2;
use vjezba2;

create table decko (
	sifra int not null primary key auto_increment,
	indiferentno bit,
	vesta varchar(34),
	asocijalno bit not null
);

create table prijatelj (
	sifra int not null primary key auto_increment,
	modelnaocala varchar(37),
	treciputa datetime not null,
	ekstroventno bit not null,
	prviputa datetime,
	svekar int not null
);

create table cura (
	sifra int not null primary key auto_increment,
	haljina varchar(33) not null,
	drugiputa datetime not null,
	suknja varchar(38),
	narukvica int,
	introventno bit,
	majica varchar(40) not null,
	decko int
);

create table decko_zarucnica (
	sifra int not null primary key auto_increment,
	decko int not null,
	zarucnica int not null
);

create table svekar (
	sifra int not null primary key auto_increment,
	stilfrizura varchar(48),
	ogrlica int not null,
	asocijalno bit not null
);

create table zarucnica (
	sifra int not null primary key auto_increment,
	narukvica int,
	bojakose varchar(37) not null,
	novcica decimal(15,9),
	lipa decimal(15,8) not null,
	indiferentno bit not null
);

create table brat (
	sifra int not null primary key auto_increment,
	suknja varchar(47),
	ogrlica int not null,
	asocijalno bit not null,
	neprijatelj int not null
);

create table neprijatelj (
	sifra int not null primary key auto_increment,
	majica varchar(32),
	haljina varchar(43) not null,
	lipa decimal(16,8),
	modelnaocala varchar(49) not null,
	kuna decimal(12,6) not null,
	jmbg char(11),
	cura int
);

alter table cura add foreign key(decko) references decko(sifra);
alter table decko_zarucnica add foreign key(decko) references decko(sifra);
alter table prijatelj add foreign key(svekar) references svekar(sifra);
alter table decko_zarucnica add foreign key(zarucnica) references zarucnica(sifra);
alter table neprijatelj add foreign key(cura) references cura(sifra);
alter table brat add foreign key(neprijatelj) references neprijatelj(sifra);


#neprijatelj,cura,decko_zarucnica 3 retka

insert into zarucnica(bojakose,lipa,indiferentno) values
('crvena',45.67,1);

insert into decko(asocijalno) values
(0);

insert into decko_zarucnica(decko,zarucnica) values
(1,1),
(1,1),
(1,1);

insert into cura(haljina,drugiputa,majica) values
('plava','2021-05-22','zuta'),
('crvena','2021-05-23','plava'),
('zelena','2021-05-24','crna');

insert into neprijatelj(haljina,modelnaocala,kuna) values
('plava','zute',15.98),
('crvena','crna',25.89),
('zuta','zelena',67.58);

select * from zarucnica;
select * from decko;
select * from decko_zarucnica;
select * from cura;
select * from neprijatelj;

#tablica prijatelj kolona treciputa vrijednost na 30. travnja 2020.

insert into svekar(ogrlica,asocijalno) values
(1,1);
insert into prijatelj(treciputa,ekstroventno,svekar) values
('1994-04-04',1,1);
update prijatelj set treciputa='2020-04-30';
select * from prijatelj;




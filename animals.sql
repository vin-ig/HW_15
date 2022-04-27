select * from animals
limit 10;

create table animal_types(
    id integer primary key autoincrement,
    type varchar(100) not null
);

-- create table age_upon_outcome(
--     id integer primary key autoincrement,
--     age varchar(10) not null
-- );

create table breed(
    id integer primary key,
    breed varchar(100) not null
);

create table colors(
    id integer primary key autoincrement,
    color varchar(50) not null
);

create table outcome_subtypes(
    id integer primary key autoincrement,
    subtype varchar(50)
);

create table outcome_types(
    id integer primary key autoincrement,
    type varchar(50)
);

create table main(
    id  integer primary key autoincrement,
    animal_id varchar(20) not null,
    animal_type varchar(100),
    name varchar(100),
    date_of_birth date,
    age_upon_outcome varchar(20),
    breed varchar(100),
    color1 varchar(100),
    color2 varchar(100),
    outcome_subtype varchar(50),
    outcome_type varchar(50),
    outcome_month integer,
    outcome_year integer,
--     foreign key (age_upon_outcome) references age_upon_outcome(age),
    foreign key (animal_type) references animal_types(id),
    foreign key (breed) references breed(id),
    foreign key (color1) references colors(id),
    foreign key (color2) references colors(id),
    foreign key (outcome_subtype) references outcome_subtypes(id),
    foreign key (outcome_type) references outcome_types(id)
);

-- Заполняем малые таблицы

insert into animal_type (type)
select distinct animal_type from animals;

insert into breed (breed)
select distinct breed from animals;

insert into colors (color)
select distinct color1 from animals;

insert into outcome_subtypes (subtype)
select distinct outcome_subtype from animals;

insert into outcome_types (type)
select distinct outcome_type from animals;

-- Заполняем основную таблицу

update animals
set breed = id from breed
where animals.breed = breed.breed



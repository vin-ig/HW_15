-- Типы животных

create table animal_types(
    id integer primary key autoincrement,
    type varchar(100) not null
);

insert into animal_types (type)
select distinct animal_type from animals;

-- Породы

create table breed(
    id integer primary key,
    breed varchar(100) not null
);

insert into breed (breed)
select distinct breed from animals;

-- Цвета

create table colors(
    id integer primary key autoincrement,
    color varchar(50) not null
);

insert into colors (color)
select distinct color1 from animals;

-- Программы

create table outcome_subtypes(
    id integer primary key autoincrement,
    subtype varchar(50) not null
);

insert into outcome_subtypes (subtype)
select distinct outcome_subtype from animals
where outcome_subtype not null;

-- Программы

create table outcome_types(
    id integer primary key autoincrement,
    type varchar(50) not null
);

insert into outcome_types (type)
select distinct outcome_type from animals
where outcome_type not null;

-- Главная таблица

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
    foreign key (animal_type) references animal_types(id),
    foreign key (breed) references breed(id),
    foreign key (color1) references colors(id),
    foreign key (color2) references colors(id),
    foreign key (outcome_subtype) references outcome_subtypes(id),
    foreign key (outcome_type) references outcome_types(id)
);

-- Заполняем основную таблицу

insert into main (animal_id, animal_type, name, date_of_birth, age_upon_outcome, breed,
                  color1, color2, outcome_subtype, outcome_type, outcome_month, outcome_year)
select animal_id, animal_type, name, date_of_birth, age_upon_outcome, breed,
                  color1, color2, outcome_subtype, outcome_type, outcome_month, outcome_year from animals;

-- Обновляем столбцы

update main
set breed = (select id from breed
where main.breed = breed.breed);

update main
set animal_type = (select id from animal_types
where main.animal_type = animal_types.type);

update main
set outcome_subtype = (select id from outcome_subtypes
where main.outcome_subtype = outcome_subtypes.subtype);

update main
set outcome_type = (select id from outcome_types
where main.outcome_type = outcome_types.type);

update main
set color1 = (select id from colors
where main.color1 = colors.color);

update main
set color2 = (select id from colors
where main.color2 = colors.color);


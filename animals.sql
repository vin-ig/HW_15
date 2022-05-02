-- Типы животных

CREATE TABLE animal_types(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(100) NOT NULL
);

INSERT INTO animal_types (type)
SELECT DISTINCT animal_type FROM animals;

-- Породы

CREATE TABLE breed(
    id INTEGER PRIMARY KEY,
    breed VARCHAR(100) NOT NULL
);

INSERT INTO breed (breed)
SELECT DISTINCT breed FROM animals;

-- Цвета

CREATE TABLE color_1(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    color VARCHAR(50) NOT NULL
);

CREATE TABLE color_2(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    color VARCHAR(50)
);

INSERT INTO color_1 (color)
SELECT DISTINCT color1 FROM animals
WHERE color1 NOT NULL;

INSERT INTO color_2 (color)
SELECT DISTINCT color2 FROM animals
WHERE color2 NOT NULL;

-- Программы

CREATE TABLE outcome_subtypes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    subtype VARCHAR(50) NOT NULL
);

INSERT INTO outcome_subtypes (subtype)
SELECT DISTINCT outcome_subtype FROM animals
WHERE outcome_subtype NOT NULL;

-- Что с животным сейчас

CREATE TABLE outcome_types(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type VARCHAR(50) NOT NULL
);

INSERT INTO outcome_types (type)
SELECT DISTINCT outcome_type FROM animals
WHERE outcome_type NOT NULL;

-- Главная таблица

CREATE TABLE main(
    id  INTEGER PRIMARY KEY AUTOINCREMENT,
    animal_id VARCHAR(20) NOT NULL,
    animal_type VARCHAR(100),
    name VARCHAR(100),
    date_of_birth DATE,
    age_upon_outcome VARCHAR(20),
    breed VARCHAR(100),
    color1 VARCHAR(100),
    color2 VARCHAR(100),
    outcome_subtype VARCHAR(50),
    outcome_type VARCHAR(50),
    outcome_month INTEGER,
    outcome_year INTEGER,
    FOREIGN KEY (animal_type) REFERENCES animal_types(id),
    FOREIGN KEY (breed) REFERENCES breed(id),
    FOREIGN KEY (color1) REFERENCES color_1(id),
    FOREIGN KEY (color2) REFERENCES color_2(id),
    FOREIGN KEY (outcome_subtype) REFERENCES outcome_subtypes(id),
    FOREIGN KEY (outcome_type) REFERENCES outcome_types(id)
);

-- Заполняем основную таблицу

INSERT INTO main (animal_id, animal_type, name, date_of_birth, age_upon_outcome, breed,
                  color1, color2, outcome_subtype, outcome_type, outcome_month, outcome_year)
SELECT animal_id, animal_type, name, date_of_birth, age_upon_outcome, breed,
                  color1, color2, outcome_subtype, outcome_type, outcome_month, outcome_year from animals;

-- Обновляем столбцы

UPDATE main
SET breed = (SELECT id FROM breed
WHERE main.breed = breed.breed);

UPDATE main
SET animal_type = (SELECT id FROM animal_types
WHERE main.animal_type = animal_types.type);

UPDATE main
SET outcome_subtype = (SELECT id FROM outcome_subtypes
WHERE main.outcome_subtype = outcome_subtypes.subtype);

UPDATE main
SET outcome_type = (SELECT id FROM outcome_types
WHERE main.outcome_type = outcome_types.type);

UPDATE main
SET color1 = (SELECT id FROM colors
WHERE main.color1 = colors.color);

UPDATE main
SET color2 = (SELECT id FROM colors
WHERE main.color2 = colors.color);

-- Объединяем таблицы

SELECT
    main.id,
    main.animal_id,
    animal_types.type,
    main.name,
    main.date_of_birth,
    breed.breed,
    color_1.color,
    color_2.color,
    os.subtype
FROM main
LEFT JOIN animal_types ON main.animal_type = animal_types.id
LEFT JOIN breed ON main.breed = breed.id
LEFT JOIN color_1 ON main.color1 = color_1.id
LEFT JOIN color_2 ON main.color2 = color_2.id
LEFT JOIN outcome_subtypes os ON main.outcome_subtype = os.id
LEFT JOIN outcome_types ot ON main.outcome_type = ot.id;

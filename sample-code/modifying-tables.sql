-- CREATE TABLE:
----------------------------------------------------------

-- create the contacts table
-- NOT NULL: ensures there is always a value
-- UNIQUE: ensures that the value is unique
DROP TABLE IF EXISTS pokemon;
DROP TABLE IF EXISTS type_lookup;

CREATE TABLE typelookup (
        id INTEGER NOT NULL,
        title VARCHAR NOT NULL,
        PRIMARY KEY (id)
);

CREATE TABLE pokemon (
        id INTEGER NOT NULL,
        name VARCHAR(30) NOT NULL,
        description VARCHAR(120) NOT NULL,
        image_url VARCHAR NOT NULL,
        type_id INTEGER NOT NULL,
        PRIMARY KEY (id),
        UNIQUE (id),
        FOREIGN KEY(type_id) REFERENCES typelookup (id)
);

-- INSERT:
----------------------------------------------------------

-- we'll insert values into the type lookup
-- this will hold all the possible pokemon types
INSERT INTO typelookup
VALUES
    (1, 'normal'),
    (2, 'fighting'),
    (3, 'flying'),
    (4, 'poison'),
    (5, 'ground'),
    (6, 'rock'),
    (7, 'bug'),
    (8, 'ghost'),
    (9, 'steel'),
    (10, 'fire'),
    (11, 'water'),
    (12, 'grass'),
    (13, 'electric'),
    (14, 'psychic'),
    (15, 'ice'),
    (16, 'ghost'),
    (17, 'dark'),
    (18, 'fairy');

-- UPDATE:
----------------------------------------------------------

-- since i put 'ghost' in twice and there is no 'dragon' type

UPDATE typelookup
SET title = 'dragon'
WHERE id = 16;

-- UPDATE:
----------------------------------------------------------

-- delete a specific row
DELETE FROM typelookup
WHERE title = 'bug';

-- delete based on a condition
DELETE FROM typelookup
WHERE id > 15;

-- delete everything
DELETE FROM typelookup;

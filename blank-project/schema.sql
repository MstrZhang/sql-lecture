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
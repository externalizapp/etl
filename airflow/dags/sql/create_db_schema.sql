DROP TABLE stg_awards;

DROP TABLE fact_award;
DROP TABLE dim_purchaser;
DROP TABLE dim_supplier;
DROP TABLE dim_tender;
DROP TABLE dim_platform;
DROP TABLE dim_date;

DROP TABLE tenders;

/* Staging tables */
CREATE TABLE IF NOT EXISTS stg_awards (
    file_number VARCHAR(255),
    title VARCHAR(512),
    purchaser VARCHAR(255),
    supplier VARCHAR(255),
    value FLOAT,
    date DATE,
    source VARCHAR(512),
    platform VARCHAR(50)
);

/* Modeling tables */
CREATE TABLE IF NOT EXISTS dim_purchaser (
    id SERIAL NOT NULL,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS dim_supplier (
    id SERIAL NOT NULL,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS dim_tender (
    id SERIAL NOT NULL,
    file_number varchar(255),
    title varchar(512) NOT NULL,
    source varchar(512) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (file_number)
);

CREATE TABLE IF NOT EXISTS dim_platform (
    id SERIAL NOT NULL,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS dim_date (
    id SERIAL NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (date)
);

CREATE TABLE IF NOT EXISTS fact_award (
    id_purchaser INT NOT NULL, 
    id_supplier INT NOT NULL, 
    id_tender INT NOT NULL, 
    id_platform INT NOT NULL, 
    id_date INT NOT NULL, 
    value FLOAT NOT NULL,
    PRIMARY KEY (id_purchaser, id_supplier, id_tender, id_platform, id_date),
    FOREIGN KEY (id_supplier) REFERENCES dim_supplier(id),
    FOREIGN KEY (id_tender) REFERENCES dim_tender(id),
    FOREIGN KEY (id_platform) REFERENCES dim_platform(id),
    FOREIGN KEY (id_date) REFERENCES dim_date(id)
);

/* Operational tables */
CREATE TABLE IF NOT EXISTS tenders (
    /* Identifiers */
    id_purchaser INT NOT NULL, 
    id_tender INT NOT NULL, 
    id_platform INT NOT NULL, 

    /* For string search */
    title VARCHAR(512),
    purchaser VARCHAR(255),

    /* Other attributes */
    file_number VARCHAR(255),
    source VARCHAR(512),
    platform VARCHAR(50),
    awards JSON,

    PRIMARY KEY (id_purchaser, id_tender, id_platform)
);

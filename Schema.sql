-- SCHEMA of Netflix

DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix_titles (
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(200),
    director VARCHAR(250),
    cast TEXT,
    country VARCHAR(150),
    date_added DATE,
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(20),
    listed_in VARCHAR(250),
    description TEXT
);

SELECT * FROM netflix;
# Netflix_SQL_Project
sql project

## Overview
This project analyzes Netflix’s movies and TV shows data using SQL to answer business-driven questions and uncover content trends. It highlights data exploration techniques, analytical problem-solving, and insight generation through structured SQL queries.

## Objectives
- Analyze the distribution of content types across the platform, focusing on movies versus TV shows.
- Identify and compare the most frequently occurring content ratings for movies and TV shows.
- Examine content trends based on release years, countries of production, and duration or number of seasons.
- Explore and categorize titles using specific filters, genres, and keyword-based criteria to uncover thematic and regional patterns.

## Dataset
The dataset used in this project is sourced from Kaggle and contains detailed information on Netflix movies and TV shows:
- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema
```sql
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
```

## Business Problems and Solutions

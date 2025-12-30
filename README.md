# Netflix_SQL_Project
![Netflix_logo](https://github.com/bk9991342-cmyk/Netflix_SQL_Project/blob/main/logo.png)

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

## Exploratory Data Analysis (EDA)
**1. Total content on Netflix**
```sql
SELECT COUNT(*) AS total_titles
FROM netflix_titles;
```

**2. Movies vs TV Shows**
```sql
SELECT type, COUNT(*) AS total
FROM netflix_titles
GROUP BY type;
```

**3. Top 10 countries with most content**
```sql
SELECT country, COUNT(*) AS total_content
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 10;
```

**4. Content added per year**
```sql
SELECT YEAR(date_added) AS year_added, COUNT(*) AS total
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;
```

**5. Most common genres**
```sql
SELECT listed_in, COUNT(*) AS total
FROM netflix_titles
GROUP BY listed_in
ORDER BY total DESC
LIMIT 10;
```

**6. Top ratings on Netflix**
```sql
SELECT rating, COUNT(*) AS total
FROM netflix_titles
GROUP BY rating
ORDER BY total DESC;
```

**7. Movies released after 2015**
```sql
SELECT title, release_year
FROM netflix_titles
WHERE type = 'Movie'
AND release_year > 2015;
```

**8. TV Shows with more than 3 seasons**
```sql
SELECT title, duration
FROM netflix_titles
WHERE type = 'TV Show'
AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 3;
```

**9. Average release year by type**
```sql
SELECT type, AVG(release_year) AS avg_release_year
FROM netflix_titles
GROUP BY type;
```

**10. Indian content on Netflix**
```sql
SELECT COUNT(*) AS india_content
FROM netflix_titles
WHERE country LIKE '%India%';
```

**11. Most popular genre in India**
```sql
SELECT listed_in, COUNT(*) AS total
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY listed_in
ORDER BY total DESC
LIMIT 1;
```

**12. Content trend: Movies vs TV Shows over time**
```sql
SELECT release_year, type, COUNT(*) AS total
FROM netflix_titles
GROUP BY release_year, type
ORDER BY release_year;
```

## Business Problems and Solutions
### 1. Count the Number of Movies vs TV Shows

```sql
SELECT type, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY type;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
SELECT type, rating, COUNT(*) AS total_count
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY type, rating
ORDER BY type, total_count DESC;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT * 
FROM netflix
WHERE release_year = 2020;
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT * 
FROM
(
    SELECT 
        UNNEST(STRING_TO_ARRAY(country, ',')) AS country,
        COUNT(*) AS total_content
    FROM netflix
    GROUP BY 1
) AS t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT *
FROM (
    SELECT 
        *,
        UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix
) AS t
WHERE director_name = 'Rajiv Chilaka';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM netflix
GROUP BY 1;
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;
```

## Findings and Conclusion

- **Content Distribution:** The analysis reveals a diverse mix of movies and TV shows on Netflix, spanning multiple genres, formats, and audience ratings.
- **Audience Targeting:** Identifying the most common content ratings offers valuable insights into Netflix’s primary target audiences and content classification strategy.
- **Geographical Trends:** Country-wise analysis highlights key content-producing regions, with a strong presence from markets such as the United States and India, reflecting Netflix’s global and regional focus.
- **Content Categorization:** Keyword- and genre-based categorization provides a clearer understanding of content themes, enabling better classification and discovery of titles.

this analysis delivers a comprehensive overview of Netflix’s content landscape and demonstrates how SQL-driven insights can support data-informed content planning, regional strategy, and business decision-making.

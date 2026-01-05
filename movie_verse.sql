-- DROP IF EXIST (for re-running)
DROP TABLE IF EXISTS ratings, movie_actors, movie_genres, actors, users, genres, movies CASCADE;

-- MOVIES
CREATE TABLE movies (
  movie_id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  release_year INTEGER,
  duration INTEGER
);

-- GENRES
CREATE TABLE genres (
  genre_id SERIAL PRIMARY KEY,
  genre_name TEXT
);

-- MOVIE-GENRE RELATION
CREATE TABLE movie_genres (
  movie_id INTEGER REFERENCES movies(movie_id),
  genre_id INTEGER REFERENCES genres(genre_id),
  PRIMARY KEY(movie_id, genre_id)
);

-- ACTORS
CREATE TABLE actors (
  actor_id SERIAL PRIMARY KEY,
  name TEXT
);

-- MOVIE-ACTOR RELATION
CREATE TABLE movie_actors (
  movie_id INTEGER REFERENCES movies(movie_id),
  actor_id INTEGER REFERENCES actors(actor_id),
  PRIMARY KEY(movie_id, actor_id)
);

-- USERS
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name TEXT,
  country TEXT
);

-- RATINGS
CREATE TABLE ratings (
  rating_id SERIAL PRIMARY KEY,
  movie_id INTEGER REFERENCES movies(movie_id),
  user_id INTEGER REFERENCES users(user_id),
  rating NUMERIC(2,1),
  review TEXT,
  rating_date DATE
);

-- INSERT GENRES
INSERT INTO genres (genre_name) VALUES
('Drama'), ('Action'), ('Comedy'), ('Romance'),
('Thriller'), ('Crime'), ('Animation'), ('Biography');

-- INSERT USERS
INSERT INTO users (name, country) VALUES
('Aarav', 'India'), ('Sophie', 'UK'), ('Carlos', 'Spain'),
('Emily', 'USA'), ('Priya', 'India');


-- INSERT ACTORS (Subset)
INSERT INTO actors (name) VALUES
('Leonardo DiCaprio'), ('Shah Rukh Khan'), ('Aamir Khan'),
('Alia Bhatt'), ('Brad Pitt'), ('Ranbir Kapoor'),
('Tom Hanks'), ('Deepika Padukone'), ('Morgan Freeman'),
('Priyanka Chopra');

-- INSERT MOVIES (50 REAL MOVIES)
INSERT INTO movies (title, release_year, duration) VALUES
('Inception', 2010, 148),
('3 Idiots', 2009, 170),
('The Shawshank Redemption', 1994, 142),
('Dangal', 2016, 161),
('The Dark Knight', 2008, 152),
('Lagaan', 2001, 224),
('Pulp Fiction', 1994, 154),
('Swades', 2004, 210),
('Interstellar', 2014, 169),
('Taare Zameen Par', 2007, 165),
('The Godfather', 1972, 175),
('PK', 2014, 153),
('Zindagi Na Milegi Dobara', 2011, 155),
('Forrest Gump', 1994, 142),
('Barfi!', 2012, 151),
('The Matrix', 1999, 136),
('Black', 2005, 122),
('The Pursuit of Happyness', 2006, 117),
('Dil Chahta Hai', 2001, 183),
('The Social Network', 2010, 120),
('Chak De! India', 2007, 153),
('Fight Club', 1999, 139),
('Jab We Met', 2007, 142),
('Sholay', 1975, 204),
('Gone Girl', 2014, 149),
('Gully Boy', 2019, 154),
('Titanic', 1997, 195),
('Uri: The Surgical Strike', 2019, 138),
('12 Angry Men', 1957, 96),
('Slumdog Millionaire', 2008, 120),
('Haider', 2014, 160),
('Avengers: Endgame', 2019, 181),
('Rockstar', 2011, 159),
('Queen', 2013, 146),
('Raazi', 2018, 139),
('The Wolf of Wall Street', 2013, 180),
('Drishyam', 2015, 163),
('The Revenant', 2015, 156),
('Andhadhun', 2018, 139),
('The Lunchbox', 2013, 104),
('Don', 2006, 171),
('MS Dhoni: The Untold Story', 2016, 190),
('Munna Bhai M.B.B.S.', 2003, 156),
('Batman Begins', 2005, 140),
('The Irishman', 2019, 209),
('Tumbbad', 2018, 104),
('The Great Gatsby', 2013, 143),
('Kahaani', 2012, 122),
('Jawan', 2023, 169),
('Oppenheimer', 2023, 180);

-- MOVIE-GENRES (sample 10)
INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1, 2), (1, 5),
(2, 1), (2, 3),
(3, 1), (3, 6),
(4, 1), (4, 8),
(5, 2), (5, 5),
(6, 1), (6, 6),
(7, 2), (7, 5),
(8, 1), (8, 4),
(9, 1), (9, 2),
(10, 1), (10, 3);

-- MOVIE-ACTORS (sample 10)
INSERT INTO movie_actors (movie_id, actor_id) VALUES
(1, 1),
(2, 3),
(3, 9),
(4, 3),
(5, 1),
(6, 3),
(7, 5),
(8, 2),
(9, 1),
(10, 3);

-- SAMPLE RATINGS
INSERT INTO ratings (movie_id, user_id, rating, review, rating_date) VALUES
(1,1,9.0,'Incredible visuals and concept','2025-01-01'),
(2,2,9.5,'Funny and emotional','2025-01-05'),
(3,3,9.8,'Best movie ever','2025-01-12'),
(4,4,9.1,'Very inspiring','2025-01-20'),
(5,1,9.0,'Iconic Batman performance','2025-01-25'),
(6,2,8.9,'Epic story with emotion','2025-02-01'),
(7,3,8.5,'Crazy timeline','2025-02-05'),
(8,4,8.8,'Simple but powerful','2025-02-10'),
(9,5,9.3,'Time bending story','2025-02-15'),
(10,1,9.4,'Heart-touching and emotional','2025-02-18');





-- 1. List all movies longer than 150 minutes released after 2010.
select * from movies
where duration >150 and release_year > 2010;


--2.Find all users from India who rated any movie after January 2025.
select * from users u
inner join ratings r on u.user_id = r.user_id
where u.country = 'India' and r.rating_date > '2025-01-31';

--3. Show all actors whose names start with 'A' or end with 'Khan'.

SELECT * FROM ACTORS WHERE NAME LIKE 'A%' OR NAME LIKE '%KHAN' 


--4. List all genres that have not been linked to any movie yet.

SELECT * FROM GENRES G LEFT JOIN MOVIE_GENRES M ON G.GENRE_ID = M.GENRE_ID
WHERE MOVIE_ID IS NULL;

--5. Count the number of movies per release decade (1990s, 2000s, etc).
SELECT (FLOOR(RELEASE_YEAR/10)*10)AS DECADE,COUNT(*)AS NUM FROM MOVIES 
GROUP BY DECADE
ORDER BY NUM;

--6. Find the movies which have exactly two genres associated.

SELECT  G.MOVIE_ID , COUNT(G.MOVIE_ID),M.TITLE FROM MOVIES M INNER JOIN  MOVIE_GENRES G ON M.MOVIE_ID = G.MOVIE_ID
GROUP BY G.MOVIE_ID, M.TITLE
HAVING COUNT(G.MOVIE_ID) =2

--7. Display all movies that have received a rating of exactly 9.0.
SELECT * FROM RATINGS WHERE RATING = 9.0;

--8. List all users who have not given any ratings.
SELECT * FROM USERS U LEFT JOIN  RATINGS R ON U.USER_ID = R.USER_ID
WHERE R.RATING IS NULL;

--9. Get the total number of actors in the database.

SELECT COUNT( DISTINCT name) from actors;

--10. Display the duration of the shortest movie in each genre.

select genre_id, min(duration) from movie_genres mg inner join movies m on mg.movie_id = m.movie_id
group by genre_id

--11. Find all movies in which ‘Leonardo DiCaprio’ acted.

select m.title from movies m
inner join movie_actors ma on 
m.movie_id = ma.movie_id
inner join actors a on
ma.actor_id = a.actor_id
where a.name = 'Leonardo DiCaprio'

--12. Show the title and genre of all movies rated above 9 by any user.
SELECT DISTINCT
  m.title,
  g.genre_name
FROM movies m
JOIN ratings r
  ON m.movie_id = r.movie_id
JOIN movie_genres mg
  ON m.movie_id = mg.movie_id
JOIN genres g
  ON mg.genre_id = g.genre_id
WHERE r.rating > 9;

--13. List all users who have rated movies from the 'Action' genre.

SELECT DISTINCT
  u.user_id,
  u.name
FROM users u
JOIN ratings r
  ON u.user_id = r.user_id
JOIN movie_genres mg
  ON r.movie_id = mg.movie_id
JOIN genres g
  ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Action';

-- 14. Find movies which are in both 'Drama' and 'Thriller' genres.

SELECT
  m.movie_id,
  m.title
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE g.genre_name IN ('Drama', 'Thriller')
GROUP BY m.movie_id, m.title
HAVING COUNT(DISTINCT g.genre_name) = 2;

--15. Find all reviews that contain the word ‘emotional’.


SELECT * FROM RATINGS
WHERE REVIEW LIKE '%emotional%';

--16. List all users who gave a review starting with 'Best'.
select * from users u 
inner join ratings r
on u.user_id = r.user_id
where r.review  like 'Best%';

--17. Find movies with the word 'Dark' in the title (case-insensitive).

select title from movies
where title like '%Dark%';

--18. Show each user’s total number of ratings and categorize them as Newbie, Active, or Pro.

select u.user_id , count(r.user_id) as total,
case when count(r.user_id) = 3 then 'pro'
when count(r.user_id) = 2 then 'active' 
else 'Newbie'
end as category
from users u
left join ratings r on u.user_id = r.user_id
group by u.user_id
order by total desc

--19. Count how many movies each actor has appeared in.

select ma.actor_id , count(distinct m.title) from movie_actors ma
left join movies m on ma.movie_id = m.movie_id
group by ma.actor_id
order by count(distinct m.title)

--20. Use RANK() to show the top 3 movies per genre based on average rating.
WITH avg_ratings AS (
  SELECT
    m.movie_id,
    m.title,
    mg.genre_id,
    AVG(r.rating) AS avg_rating
  FROM movies m
  JOIN ratings r
    ON m.movie_id = r.movie_id
  JOIN movie_genres mg
    ON m.movie_id = mg.movie_id
  GROUP BY m.movie_id, m.title, mg.genre_id
),
ranked_movies AS (
  SELECT
    *,
    RANK() OVER (
      PARTITION BY genre_id
      ORDER BY avg_rating DESC
    ) AS genre_rank
  FROM avg_ratings
)
SELECT
  genre_id,
  title,
  avg_rating,
  genre_rank
FROM ranked_movies
WHERE genre_rank <= 3
ORDER BY genre_id, genre_rank;

--21. Show each movie’s rating along with the average rating for that genre using window functions.

WITH movie_avg AS (
  SELECT
    m.movie_id,
    m.title,
    mg.genre_id,
    AVG(r.rating) AS movie_avg_rating
  FROM movies m
  JOIN ratings r
    ON m.movie_id = r.movie_id
  JOIN movie_genres mg
    ON m.movie_id = mg.movie_id
  GROUP BY m.movie_id, m.title, mg.genre_id
)
SELECT
  movie_id,
  title,
  genre_id,
  movie_avg_rating,
  AVG(movie_avg_rating) OVER (PARTITION BY genre_id) AS genre_avg_rating
FROM movie_avg
ORDER BY genre_id, movie_avg_rating DESC;

--22. For each user, list the last movie they rated (by date).
SELECT
  user_id,
  name,
  title AS last_rated_movie,
  rating_date
FROM (
  SELECT
    u.user_id,
    u.name,
    m.title,
    r.rating_date,
    ROW_NUMBER() OVER (
      PARTITION BY u.user_id
      ORDER BY r.rating_date DESC
    ) AS rn
  FROM users u
  JOIN ratings r
    ON u.user_id = r.user_id
  JOIN movies m
    ON r.movie_id = m.movie_id
) t
WHERE rn = 1;

--23. Show the difference in rating each user gave compared to their previous rating using LAG().
SELECT
  r.user_id,
  r.movie_id,
  m.title,
  r.rating,
  r.rating_date,
  r.rating
    - LAG(r.rating) OVER (
        PARTITION BY r.user_id
        ORDER BY r.rating_date
      ) AS rating_diff
FROM ratings r
LEFT JOIN movies m
  ON r.movie_id = m.movie_id
ORDER BY r.user_id, r.rating_date;

--24. Use DENSE_RANK() to find the top-rated movies overall (no gaps in rank).

WITH movie_avg AS (
  SELECT
    m.movie_id,
    m.title,
    AVG(r.rating) AS avg_rating
  FROM movies m
  JOIN ratings r
    ON m.movie_id = r.movie_id
  GROUP BY m.movie_id, m.title
)
SELECT
  movie_id,
  title,
  avg_rating,
  DENSE_RANK() OVER (
    ORDER BY avg_rating DESC
  ) AS movie_rank
FROM movie_avg
ORDER BY movie_rank;




















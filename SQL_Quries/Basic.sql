-- 1. List All Movies
SELECT * FROM movies;
-- 2. Get only movie title & year
SELECT title, release_year FROM movies;
-- 3. Movies released after 2020
SELECT title, release_year FROM movies
WHERE release_year > 2020;
-- 4. Movies with rating above 8
SELECT title, rating FROM movies
WHERE rating >= 8;
-- 5.Count total Telugu movies
SELECT COUNT(*) FROM movies
WHERE industry='Tollywood';
-- 6.Movies sorted by highest rating
SELECT title, rating FROM movies
ORDER BY rating DESC;
-- 7. Find the latest OTT releases
SELECT m.title, ms.available_from 
FROM movie_streaming ms JOIN movies m 
ON ms.movie_id = m.movie_id
ORDER BY available_from DESC;
-- 8.Actor-wise movie count
SELECT a.actor_name, COUNT(mc.movie_id) AS total_movies
FROM actors a LEFT JOIN movie_cast mc 
ON (a.actor_id = mc.actor_id)
GROUP BY a.actor_name;
-- 9. Movies available on Netflix
SELECT m.title
FROM movie_streaming ms JOIN movies m 
ON (ms.movie_id = m.movie_id)
WHERE ms.platform_id = 1;
-- 10. Group movies by genre
SELECT genre, COUNT(movie_id) AS total_movies
FROM movies GROUP BY genre;


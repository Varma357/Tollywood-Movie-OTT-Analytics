# Views
-- 1. View: basic movie list
CREATE VIEW vw_movies_basic AS
SELECT movie_id, title, release_year, genre, rating FROM movies;

-- 2. View: movie with actor names 
CREATE VIEW vw_movie_actors AS
SELECT m.movie_id, m.title,
  GROUP_CONCAT(CONCAT(a.actor_name, ' as ', mc.role_name) SEPARATOR '; ') AS actors_list
FROM movies m
LEFT JOIN movie_cast mc ON (m.movie_id = mc.movie_id)
LEFT JOIN actors a ON (mc.actor_id = a.actor_id)
GROUP BY m.movie_id, m.title;

-- 3. View: actor stats
CREATE VIEW vw_actor_stats AS
SELECT a.actor_id, a.actor_name, a.age, COUNT(mc.movie_id) AS movies_count, ROUND(AVG(m.rating),2) AS avg_movie_rating
FROM actors a
LEFT JOIN movie_cast mc ON (a.actor_id = mc.actor_id)
LEFT JOIN movies m ON (mc.movie_id = m.movie_id)
GROUP BY a.actor_id, a.actor_name, a.age;

-- 4. View: top rated movies
CREATE VIEW vw_top_rated AS
SELECT movie_id, title, rating FROM movies
WHERE rating >= 8 ORDER BY rating DESC;

-- 5. View: movies per year
CREATE VIEW vw_movies_per_year AS
SELECT release_year, COUNT(*) AS movies_count FROM movies 
GROUP BY release_year ORDER BY release_year DESC;

-- 6. View: avg rating by genre
CREATE VIEW vw_avg_rating_genre AS
SELECT genre, ROUND(AVG(rating),2) AS avg_rating, COUNT(*) AS movie_count
FROM movies GROUP BY genre;

-- 7. View: movies not streamed
CREATE VIEW vw_unstreamed_movies AS
SELECT movie_id, title FROM movies 
WHERE movie_id NOT IN (SELECT movie_id FROM movie_streaming);

-- 8. View: movies with counts of actors and platforms
CREATE VIEW vw_movie_aggregates AS
SELECT m.movie_id, m.title, COUNT(DISTINCT mc.actor_id) AS actor_count, COUNT(DISTINCT ms.platform_id) AS platform_count
FROM movies m LEFT JOIN movie_cast mc ON (m.movie_id = mc.movie_id)
LEFT JOIN movie_streaming ms ON (m.movie_id = ms.movie_id)
GROUP BY m.movie_id, m.title;

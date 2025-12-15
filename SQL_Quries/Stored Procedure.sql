#Stored Procedure
-- 1. Insert a movie
DELIMITER $$
CREATE PROCEDURE sp_insert_movie(
  IN p_id INT, IN p_title VARCHAR(100), IN p_year INT,
  IN p_genre VARCHAR(50), IN p_industry VARCHAR(30), IN p_rating DECIMAL(3,1)
)
BEGIN
  INSERT INTO movies(movie_id, title, release_year, genre, industry, rating)
  VALUES(p_id, p_title, p_year, p_genre, p_industry, p_rating);
END$$

-- 2. Update movie rating
CREATE PROCEDURE sp_update_movie_rating(IN p_id INT, IN p_rating DECIMAL(3,1))
BEGIN
  UPDATE movies SET rating = p_rating WHERE movie_id = p_id;
END$$

-- 3. Delete movie and related streaming & cast (cascade manual)
CREATE PROCEDURE sp_delete_movie(IN p_id INT)
BEGIN
  DELETE FROM movie_streaming WHERE movie_id = p_id;
  DELETE FROM movie_cast WHERE movie_id = p_id;
  DELETE FROM movies WHERE movie_id = p_id;
END$$

-- 4. Get top N rated movies
CREATE PROCEDURE sp_top_n_movies(IN p_n INT)
BEGIN
  SELECT title, rating FROM movies ORDER BY rating DESC LIMIT p_n;
END$$

-- 5. Movies above average rating
CREATE PROCEDURE sp_movies_above_avg()
BEGIN
  SELECT title, rating FROM movies WHERE rating > (SELECT AVG(rating) FROM movies);
END$$

-- 6. Find movies not streamed anywhere
CREATE PROCEDURE sp_unstreamed_movies()
BEGIN
  SELECT title FROM movies WHERE movie_id NOT IN (SELECT movie_id FROM movie_streaming);
END$$

-- 7. Get actors with movie counts (descending)
CREATE PROCEDURE sp_actor_movie_counts()
BEGIN
  SELECT a.actor_name, COUNT(mc.movie_id) AS total_movies
  FROM actors a
  LEFT JOIN movie_cast mc ON a.actor_id = mc.actor_id
  GROUP BY a.actor_name
  ORDER BY total_movies DESC;
END$$

-- 8. Platform price summary (min/max/avg)
CREATE PROCEDURE sp_platform_price_stats()
BEGIN
  SELECT COUNT(*) AS platform_count, MIN(monthly_price) AS min_price, MAX(monthly_price) AS max_price, AVG(monthly_price) AS avg_price
  FROM ott_platforms;
END$$

-- 9. Avg rating by genre
CREATE PROCEDURE sp_avg_rating_by_genre()
BEGIN
  SELECT genre, ROUND(AVG(rating),2) AS avg_rating, COUNT(*) AS movies
  FROM movies GROUP BY genre ORDER BY avg_rating DESC;
END$$

-- 10. Movies with multiple platforms
CREATE PROCEDURE sp_movies_multi_platforms()
BEGIN
  SELECT m.title, COUNT(ms.platform_id) AS platform_count
  FROM movies m
  JOIN movie_streaming ms ON m.movie_id = ms.movie_id
  GROUP BY m.movie_id HAVING platform_count > 1;
END$$
DELIMITER ;
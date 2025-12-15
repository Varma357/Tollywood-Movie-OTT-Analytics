# Functions
-- 1. Get movie rating by id
DELIMITER $$
CREATE FUNCTION fn_get_movie_rating(p_mid INT) RETURNS DECIMAL(3,1) DETERMINISTIC
BEGIN
  DECLARE r DECIMAL(3,1);
  SELECT rating INTO r FROM movies WHERE movie_id = p_mid;
  RETURN r;
END$$
-- 2. Count movies for a platform
CREATE FUNCTION fn_count_movies_platform(p_pid INT) RETURNS INT DETERMINISTIC
BEGIN
  DECLARE c INT;
  SELECT COUNT(*) INTO c FROM movie_streaming WHERE platform_id = p_pid;
  RETURN c;
END$$

-- 3. Is movie streamed? (1=yes,0=no)
CREATE FUNCTION fn_is_streamed(p_mid INT) RETURNS TINYINT DETERMINISTIC
BEGIN
  DECLARE cnt INT;
  SELECT COUNT(*) INTO cnt FROM movie_streaming WHERE movie_id = p_mid;
  RETURN IF(cnt > 0, 1, 0);
END$$

-- 4. Number of actors in a movie
CREATE FUNCTION fn_actor_count_movie(p_mid INT) RETURNS INT DETERMINISTIC
BEGIN
  DECLARE c INT;
  SELECT COUNT(*) INTO c FROM movie_cast WHERE movie_id = p_mid;
  RETURN c;
END$$

-- 5. Get oldest actor age
CREATE FUNCTION fn_oldest_actor() RETURNS INT DETERMINISTIC
BEGIN
  DECLARE a INT;
  SELECT MAX(age) INTO a FROM actors;
  RETURN a;
END$$

-- 6. Check movie exists (1/0)
CREATE FUNCTION fn_movie_exists(p_mid INT) RETURNS TINYINT DETERMINISTIC
BEGIN
  DECLARE c INT;
  SELECT COUNT(*) INTO c FROM movies WHERE movie_id = p_mid;
  RETURN IF(c>0,1,0);
END$$

-- 7. Get highest rating in platform
CREATE FUNCTION fn_max_rating_for_platform(p_pid INT) RETURNS DECIMAL(3,1) DETERMINISTIC
BEGIN
  DECLARE r DECIMAL(3,1);
  SELECT MAX(m.rating) INTO r
  FROM movie_streaming ms JOIN movies m ON ms.movie_id = m.movie_id
  WHERE ms.platform_id = p_pid;
  RETURN r;
END$$

-- 8. Years since movie release
CREATE FUNCTION fn_years_since_release(p_mid INT) RETURNS INT DETERMINISTIC
BEGIN
  DECLARE y INT;
  SELECT YEAR(CURDATE()) - release_year INTO y FROM movies WHERE movie_id = p_mid;
  RETURN y;
END$$

-- 9. Count platforms for a movie
CREATE FUNCTION fn_platforms_for_movie(p_mid INT) RETURNS INT DETERMINISTIC
BEGIN
  DECLARE c INT;
  SELECT COUNT(DISTINCT platform_id) INTO c FROM movie_streaming WHERE movie_id = p_mid;
  RETURN c;
END$$

-- 10. Get earliest movie year in DB
CREATE FUNCTION fn_earliest_release_year() RETURNS INT DETERMINISTIC
BEGIN
  DECLARE y INT;
  SELECT MIN(release_year) INTO y FROM movies;
  RETURN y;
END$$
DELIMITER ;
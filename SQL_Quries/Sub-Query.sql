# Sub-Query
use movies;
-- 1.Movies rated higher than RRR
SELECT title, rating FROM movies
WHERE rating > (SELECT rating FROM movies WHERE title = 'RRR');

-- 2. Actors who acted in more movies than Prabhas
SELECT actor_name FROM actors
WHERE actor_id IN (
    SELECT actor_id FROM movie_cast
    GROUP BY actor_id
    HAVING COUNT(movie_id) > (SELECT COUNT(movie_id) FROM movie_cast WHERE actor_id = 201));

-- 3. Movies with same genre as Pushpa
SELECT title FROM movies
WHERE genre = (SELECT genre FROM movies WHERE title = 'Pushpa: The Rise');

-- 5. OTT platform with highest price
SELECT platform_name FROM ott_platforms
WHERE monthly_price = (SELECT MAX(monthly_price) FROM ott_platforms);

-- 6. Movies released before earliest OTT availability
SELECT title FROM movies
WHERE release_year < (SELECT MIN(YEAR(available_from)) FROM movie_streaming);

-- 7. Movies having same actors as RRR
SELECT DISTINCT m.title
FROM movie_cast mc JOIN movies m ON (mc.movie_id = m.movie_id)
WHERE mc.actor_id IN (SELECT actor_id FROM movie_cast WHERE movie_id = 12)
AND m.movie_id != 12;

-- 8. Movies streamed on both Netflix & Amazon Prime
SELECT title FROM movies
WHERE movie_id IN (SELECT movie_id FROM movie_streaming WHERE platform_id = 1) AND 
    movie_id IN (SELECT movie_id FROM movie_streaming WHERE platform_id = 2);

-- 9. Movies not streamed anywhere
SELECT title FROM movies
WHERE movie_id NOT IN (SELECT movie_id FROM movie_streaming);

-- 10. Actor with maximum movies
SELECT actor_name FROM actors
WHERE actor_id = (
SELECT actor_id FROM movie_cast
GROUP BY actor_id ORDER BY COUNT(movie_id) DESC LIMIT 1
);

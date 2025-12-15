# Joins
-- 1. Actor & OTT Platform Together
SELECT a.actor_name, m.title, o.platform_name
FROM movie_cast mc JOIN actors a ON (mc.actor_id = a.actor_id)
JOIN movies m ON (mc.movie_id = m.movie_id)
JOIN movie_streaming ms ON (m.movie_id = ms.movie_id)
JOIN ott_platforms o ON (ms.platform_id = o.platform_id);

-- 2. Movies featuring actors older than 40
SELECT m.title, a.actor_name, a.age
FROM movie_cast mc 
JOIN actors a ON (mc.actor_id = a.actor_id)
JOIN movies m ON mc.movie_id = m.movie_id
WHERE a.age > 40;

-- 3.Highest-rated movie per OTT platform
SELECT o.platform_name, m.title, m.rating
FROM movie_streaming ms JOIN movies m ON (ms.movie_id = m.movie_id)
JOIN ott_platforms o ON (ms.platform_id = o.platform_id)
WHERE (o.platform_id, m.rating) IN (
    SELECT platform_id, MAX(rating)
    FROM movie_streaming ms2 JOIN movies m2 ON (ms2.movie_id = m2.movie_id)
    GROUP BY platform_id
);

-- 4. Top 5 latest streamed movies
SELECT m.title, ms.available_from
FROM movie_streaming ms JOIN movies m ON (ms.movie_id = m.movie_id)
ORDER BY ms.available_from DESC LIMIT 5;

-- 5. Actor and number of OTT movies
SELECT a.actor_name, COUNT(ms.movie_id) AS ott_movies
FROM actors a JOIN movie_cast mc ON (a.actor_id = mc.actor_id)
JOIN movie_streaming ms ON (mc.movie_id = ms.movie_id)
GROUP BY a.actor_name;

-- 6. Actors who acted in Aha movies
SELECT DISTINCT a.actor_name
FROM actors a  JOIN movie_cast mc ON (a.actor_id = mc.actor_id)
JOIN movie_streaming ms ON (mc.movie_id = ms.movie_id)
WHERE ms.platform_id = 4;

-- 7. Total revenue per platform
SELECT o.platform_name, COUNT(ms.movie_id) * o.monthly_price AS estimated_revenue
FROM ott_platforms o  JOIN movie_streaming ms ON (o.platform_id = ms.platform_id)
GROUP BY o.platform_name, o.monthly_price;

-- 8. Movies with no OTT platform
SELECT m.title
FROM movies m LEFT JOIN movie_streaming ms ON (m.movie_id = ms.movie_id)
WHERE ms.movie_id IS NULL;

-- 9. Actors with no movie cast
SELECT a.actor_name
FROM actors a LEFT JOIN movie_cast mc ON (a.actor_id = mc.actor_id)
WHERE mc.movie_id IS NULL;

-- 10. Show actor + movie + OTT + price
SELECT a.actor_name, m.title, o.platform_name, o.monthly_price
FROM movie_cast mc
JOIN actors a ON (mc.actor_id = a.actor_id)
JOIN movies m ON (mc.movie_id = m.movie_id)
JOIN movie_streaming ms ON (m.movie_id = ms.movie_id)
JOIN ott_platforms o ON (ms.platform_id = o.platform_id);
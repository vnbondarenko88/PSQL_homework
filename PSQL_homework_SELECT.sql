-- Задание 2 

-- 2.1
SELECT track_name, MAX(track_duration)
FROM track
GROUP BY track_name
ORDER BY MAX(track_duration) DESC
LIMIT 1;

-- 2.2
SELECT track_name, track_duration
FROM track
WHERE track_duration >= 210;

-- 2.3
SELECT name
FROM collection
WHERE year_release BETWEEN 2018 AND 2020;

-- 2.4
SELECT name
FROM singer
WHERE name NOT LIKE '% %';

-- 2.5
SELECT track_name 
FROM track
WHERE track_name LIKE '% my %' OR track_name LIKE '% мой %';


-- Задание 3 

-- 3.1
SELECT mg.name, COUNT(s.singer_id) 
FROM musical_genre mg 
	JOIN musical_genre_singer mgs
	ON mg.musical_genre_id = mgs.musical_genre_id 
	JOIN singer s 
	ON mgs.singer_id = s.singer_id 
GROUP BY mg.name; 

-- 3.2

SELECT COUNT(*)
FROM track t
	JOIN album a 
	ON t.album_id = a.album_id 
WHERE year_release BETWEEN 2019 AND 2020;

-- 3.3
SELECT album_name, AVG(track_duration)
FROM album a
	JOIN track t
	ON a.album_id  = t.album_id  
GROUP BY album_name; 

-- 3.4
SELECT name
FROM singer s 
	JOIN singer_album sa 
	ON s.singer_id = sa.singer_id 
	JOIN album a 
	ON sa.album_id = a.album_id 
WHERE year_release != 2020;

-- 3.5
SELECT c.name 
FROM singer s
	JOIN singer_album sa 
	ON s.singer_id = sa.singer_id 
	JOIN album a
	ON sa.album_id = a.album_id 
	JOIN track t
	ON a.album_id = t.album_id 
	JOIN track_collection tc 
	ON t.track_id  = tc.track_id 
	JOIN collection c 
	ON tc.collection_id = c.collection_id 
WHERE s.name LIKE 'Eminem';

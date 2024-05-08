SELECT track_name, MAX(track_duration)
FROM track
GROUP BY track_name
ORDER BY MAX(track_duration) DESC
LIMIT 1;


SELECT track_name, track_duration
FROM track
WHERE track_duration >= 210;


SELECT name
FROM collection
WHERE year_release BETWEEN 2018 AND 2020;


SELECT name
FROM singer
WHERE name NOT LIKE '% %';


SELECT track_name 
FROM track
WHERE track_name LIKE '% my %' OR track_name LIKE '% мой %';
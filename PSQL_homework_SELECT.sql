-- Задание 2 

-- 2.1 Название и продолжительность самого длительного трека. Правка № 1
SELECT track_name
FROM track
WHERE track_duration  >= (SELECT MAX(track_duration) FROM track);


-- 2.2 Название треков, продолжительность которых не менее 3,5 минут.
SELECT track_name, track_duration
FROM track
WHERE track_duration >= 210;


-- 2.3 Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT name
FROM collection
WHERE year_release BETWEEN 2018 AND 2020;


-- 2.4 Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM singer
WHERE name NOT LIKE '% %';


-- 2.5 Название треков, которые содержат слово «мой» или «my».
SELECT track_name 
FROM track
WHERE track_name LIKE '% my %' OR track_name LIKE '% мой %';


-- Задание 3 

-- 3.1 Количество исполнителей в каждом жанре.
SELECT mg.name, COUNT(s.singer_id) 
FROM musical_genre mg 
	JOIN musical_genre_singer mgs
	ON mg.musical_genre_id = mgs.musical_genre_id 
	JOIN singer s 
	ON mgs.singer_id = s.singer_id 
GROUP BY mg.name; 


-- 3.2 Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(*)
FROM track t
	JOIN album a 
	ON t.album_id = a.album_id 
WHERE year_release BETWEEN 2019 AND 2020;


-- 3.3 Средняя продолжительность треков по каждому альбому.
SELECT album_name, AVG(track_duration)
FROM album a
	JOIN track t
	ON a.album_id  = t.album_id  
GROUP BY album_name; 


-- 3.4 Все исполнители, которые не выпустили альбомы в 2020 году. Правка № 1
SELECT name
FROM singer s 
	JOIN singer_album sa 
	ON s.singer_id = sa.singer_id 
	JOIN album a 
	ON sa.album_id = a.album_id 
WHERE s.name NOT IN (SELECT s.name FROM singer WHERE year_release = 2020);


-- 3.5 Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами). Правка № 1
SELECT c.name 
FROM singer s
	JOIN singer_album sa 
	ON s.singer_id = sa.singer_id 
	JOIN track t
	ON sa.album_id = t.album_id 
	JOIN track_collection tc 
	ON t.track_id  = tc.track_id 
	JOIN collection c 
	ON tc.collection_id = c.collection_id 
WHERE s.name LIKE 'Eminem';



-- Задание 4

-- 4.1 Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT c.name 
FROM musical_genre mg 
	JOIN musical_genre_singer mgs
	ON mg.musical_genre_id = mgs.musical_genre_id 
	JOIN singer s 
	ON mgs.singer_id = s.singer_id 
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
GROUP BY c.name
HAVING COUNT(s.singer_id) > 1;


-- 4.2 Наименования треков, которые не входят в сборники.
SELECT track_name 
FROM track t 
	LEFT JOIN track_collection tc 
	ON t.track_id = tc.track_id 
WHERE tc.track_id IS NULL;


-- 4.3 Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, 
-- теоретически таких треков может быть несколько.
SELECT s.name
FROM singer s 
	JOIN singer_album sa 
	ON s.singer_id = sa.singer_id 
	JOIN album a 
	ON sa.album_id = a.album_id 
	JOIN track t 
	ON a.album_id = t.album_id
WHERE t.track_duration <= (SELECT MIN(track_duration) FROM track);


-- 4.4 Названия альбомов, содержащих наименьшее количество треков. Правка № 1
SELECT a.album_name, COUNT(t.track_id)
FROM album a 
	JOIN track t
	ON a.album_id = t.album_id 
GROUP BY a.album_name
HAVING COUNT(t.track_id) = (SELECT COUNT(tr.track_id) 
							FROM album al
							JOIN track tr
							ON al.album_id = tr.album_id
							GROUP BY al.album_name
							ORDER BY COUNT(tr.track_id)
							LIMIT 1);




INSERT INTO musical_genre(name)
VALUES  ('Хип-хоп'),
		('Рок'),
		('Поп музыка');


INSERT INTO singer (name)
VALUES 	('Eminem'), 
		('50 cent'),
		('БИ-2'),
		('Кино'),
		('Дмитрий Билан'),
		('30 seconds to mars');



INSERT INTO musical_genre_singer (musical_genre_id, singer_id)
VALUES	(1, 1),
		(1, 2),
		(2, 3),
		(2, 4),
		(3, 5),
		(2, 6);


INSERT INTO album (album_name, year_release)
VALUES	('Recovery', 2010),
		('The Massacre', 2005),
		('Аллилуя', 2022),
		('Звезда по имени солнце', 1989),
		('Believe', 2009),
		('America', 2018);



INSERT INTO singer_album (album_id, singer_id)
VALUES	(1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 5),
		(6, 6);




INSERT INTO track (track_name, track_duration, album_id)
VALUES	('So Bad', 325, 1),
		('Get in my car', 245, 2),
		('Депрессия', 251, 3),
		('Звезда по имени солнце', 225, 4),
		('Mistakes', 230, 5),
		('«Walk on water', 185, 6);





INSERT INTO collection (name, year_release)
VALUES	('first_collection', 2019),
		('second_collection', 2015),
		('rus_songs', 2020),
		('america_songs', 2023);





INSERT INTO track_collection (track_id, collection_id)
VALUES	(4, 1),
		(5, 1),
		(2, 1),
		(1, 2),
		(3, 2),
		(6, 2),
		(3, 3),
		(4, 3),
		(5, 3),
		(1, 4),
		(2, 4),
		(6, 4);

























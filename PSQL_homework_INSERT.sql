INSERT INTO musical_genre(name)
VALUES  ('Хип-хоп'),
		('Рок'),
		('Поп музыка');


INSERT INTO singer (name)
VALUES ('Eminem'), 
	  ('50 cent'),
	  ('БИ-2'),
	  ('Кино'),
	  ('Дмитрий Билан'),
	  ('30 seconds to mars'),
	  ('singer_1'),
	  ('singer_2'),
	  ('singer_3');



INSERT INTO musical_genre_singer (musical_genre_id, singer_id)
VALUES (1, 1),
	   (1, 2),
	   (2, 3),
	   (2, 4),
	   (3, 5),
	   (2, 6),
	   (3, 7),
	   (1, 8),
	   (2, 9);


INSERT INTO album (album_name, year_release)
VALUES ('Recovery', 2010),
	   ('The Massacre', 2005),
	   ('Аллилуя', 2022),
	   ('Звезда по имени солнце', 1989),
	   ('Believe', 2009),
	   ('America', 2019),
	   ('album_1', 2020),
	   ('album_2', 2021),
	   ('album_3', 2018);



INSERT INTO singer_album (album_id, singer_id)
VALUES (1, 1),
	   (2, 2),
	   (3, 3),
	   (4, 4),
	   (5, 5),
	   (6, 6),
	   (7, 7),
	   (8, 8),
	   (9, 9),
	   (9, 2),
	   (9, 3),
	   (7, 1);




INSERT INTO track (track_name, track_duration, album_id)
VALUES ('So Bad', 325, 1),
       ('Get in my car', 245, 2),
       ('Депрессия', 251, 3),
       ('Звезда по имени солнце', 225, 4),
       ('Mistakes', 230, 5),
       ('«Walk on water', 185, 6),
       ('track_1', 210, 7),
       ('track_2', 250, 8),
       ('track_3', 190, 9),
       ('track_4', 210, 1),
       ('track_5', 230, 2),
       ('track_6', 213, 3),
       ('track_7', 198, 4),
       ('track_8', 215, 5),
       ('track_9', 220, 6),
       ('track_10', 220, 7),
       ('track_11', 220, 9);





INSERT INTO collection (name, year_release)
VALUES	('first_collection', 2019),
		('second_collection', 2015),
		('rus_songs', 2020),
		('america_songs', 2023);





INSERT INTO track_collection (track_id, collection_id)
VALUES (4, 1),
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
	   (6, 4),
	   (7, 1);

























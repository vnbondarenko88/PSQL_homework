CREATE TABLE IF NOT EXISTS musical_genre (
	musical_genre_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);


INSERT INTO musical_genre(name)
VALUES ('Хип-хоп'),
		('Рок'),
		('Поп музыка');


CREATE TABLE IF NOT EXISTS singer (
	singer_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);


INSERT INTO singer (name)
VALUES ('Eminem'), 
	  ('50 cent'),
	  ('БИ-2'),
	  ('Кино'),
	  ('Дмитрий Билан'),
	  ('30 seconds to mars');





CREATE TABLE IF NOT EXISTS musical_genre_singer (
	musical_genre_singer_id SERIAL PRIMARY KEY,
	musical_genre_id INT NOT NULL,
	singer_id INT NOT NULL,
	CONSTRAINT fk_genre FOREIGN KEY (musical_genre_id) REFERENCES musical_genre(musical_genre_id) ON DELETE CASCADE,
	CONSTRAINT fk_singer FOREIGN KEY (singer_id) REFERENCES singer(singer_id) ON DELETE CASCADE
);



INSERT INTO musical_genre_singer (musical_genre_id, singer_id)
VALUES (1, 1),
	   (1, 2),
	   (2, 3),
	   (2, 4),
	   (3, 5),
	   (2, 6);





CREATE TABLE IF NOT EXISTS album (
	album_id SERIAL PRIMARY KEY,
	album_name VARCHAR(60) NOT NULL,
	year_release INT NOT NULL
);


INSERT INTO album (album_name, year_release)
VALUES ('Recovery', 2010),
	   ('The Massacre', 2005),
	   ('Аллилуя', 2022),
	   ('Звезда по имени солнце', 1989),
	   ('Believe', 2009),
	   ('America', 2018);




CREATE TABLE IF NOT EXISTS singer_album (
	singer_album_id SERIAL PRIMARY KEY,
	album_id INT NOT NULL,
	singer_id INT NOT NULL,
	CONSTRAINT fk_album FOREIGN KEY (album_id) REFERENCES album(album_id) ON DELETE CASCADE,
	CONSTRAINT fk_singer FOREIGN KEY (singer_id) REFERENCES singer(singer_id) ON DELETE CASCADE
);



INSERT INTO singer_album (album_id, singer_id)
VALUES (1, 1),
	   (2, 2),
	   (3, 3),
	   (4, 4),
	   (5, 5),
	   (6, 6);





CREATE TABLE IF NOT EXISTS track (
	track_id SERIAL PRIMARY KEY,
	track_name VARCHAR(60) NOT NULL,
	track_duration INT NOT NULL,
	album_id INTEGER REFERENCES album(album_id) NOT NULL
);



INSERT INTO track (track_name, track_duration, album_id)
VALUES ('So Bad', 325, 1),
       ('Get in my car', 245, 2),
       ('Депрессия', 251, 3),
       ('Звезда по имени солнце', 225, 4),
       ('Mistakes', 230, 5),
       ('«Walk on water', 185, 6);





CREATE TABLE IF NOT EXISTS collection (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year_release INT NOT NULL
);



INSERT INTO collection (name, year_release)
VALUES ('first_collection', 2019),
       ('second_collection', 2015),
       ('rus_songs', 2020),
       ('america_songs', 2023);




CREATE TABLE IF NOT EXISTS track_collection (
	track_collection_id SERIAL PRIMARY KEY,
	track_id INT NOT NULL,
	collection_id INT NOT NULL,
	CONSTRAINT fk_track FOREIGN KEY (track_id) REFERENCES track(track_id) ON DELETE CASCADE,
	CONSTRAINT fk_collection FOREIGN KEY (collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE
);

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
	   (6, 4);




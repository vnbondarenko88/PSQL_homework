CREATE TABLE IF NOT EXISTS musical_genre (
	musical_genre_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL
);


CREATE TABLE IF NOT EXISTS singer (
	singer_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL
);


CREATE TABLE IF NOT EXISTS musical_genre_singer (
	musical_genre_singer_id SERIAL PRIMARY KEY,
	musical_genre_id INT NOT NULL,
	singer_id INT NOT NULL,
	CONSTRAINT fk_genre FOREIGN KEY (musical_genre_id) REFERENCES musical_genre(musical_genre_id) ON DELETE CASCADE,
	CONSTRAINT fk_singer FOREIGN KEY (singer_id) REFERENCES singer(singer_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS album (
	album_id SERIAL PRIMARY KEY,
	album_name VARCHAR(60) NOT NULL,
	year_release INT NOT NULL
);


CREATE TABLE IF NOT EXISTS singer_album (
	singer_album_id SERIAL PRIMARY KEY,
	album_id INT NOT NULL,
	singer_id INT NOT NULL,
	CONSTRAINT fk_album FOREIGN KEY (album_id) REFERENCES album(album_id) ON DELETE CASCADE,
	CONSTRAINT fk_singer FOREIGN KEY (singer_id) REFERENCES singer(singer_id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS track (
	track_id SERIAL PRIMARY KEY,
	track_name VARCHAR(60) NOT NULL,
	track_duration INT NOT NULL,
	album_id INTEGER REFERENCES album(album_id) NOT NULL
);


CREATE TABLE IF NOT EXISTS collection (
	collection_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	year_release INT NOT NULL
);


CREATE TABLE IF NOT EXISTS track_collection (
	track_collection_id SERIAL PRIMARY KEY,
	track_id INT NOT NULL,
	collection_id INT NOT NULL,
	CONSTRAINT fk_track FOREIGN KEY (track_id) REFERENCES track(track_id) ON DELETE CASCADE,
	CONSTRAINT fk_collection FOREIGN KEY (collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE
);





INSERT INTO musical_genre(name)
VALUES ('Хип-хоп'),
		('Рок'),
		('Поп музыка');


INSERT INTO singer (name)
VALUES ('Eminem'), 
	  ('50 cent'),
	  ('БИ-2'),
	  ('Кино'),
	  ('Дмитрий Билан'),
	  ('30 seconds to mars');



INSERT INTO musical_genre_singer (musical_genre_id, singer_id)
VALUES (1, 1),
	   (1, 2),
	   (2, 3),
	   (2, 4),
	   (3, 5),
	   (2, 6);


INSERT INTO album (album_name, year_release)
VALUES ('Recovery', 2010),
	   ('The Massacre', 2005),
	   ('Аллилуя', 2022),
	   ('Звезда по имени солнце', 1989),
	   ('Believe', 2009),
	   ('America', 2018);



INSERT INTO singer_album (album_id, singer_id)
VALUES (1, 1),
	   (2, 2),
	   (3, 3),
	   (4, 4),
	   (5, 5),
	   (6, 6);




INSERT INTO track (track_name, track_duration, album_id)
VALUES ('So Bad', 325, 1),
       ('Get in my car', 245, 2),
       ('Депрессия', 251, 3),
       ('Звезда по имени солнце', 225, 4),
       ('Mistakes', 230, 5),
       ('«Walk on water', 185, 6);





INSERT INTO collection (name, year_release)
VALUES ('first_collection', 2019),
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
	   (6, 4);




arg_list = {"name": first_name, "last_name": last_name, "email": email, "phone": phone}
        for key, arg in arg_list.items():
            if arg:



cur.execute(""“
SELECT *
FROM clients cl
JOIN phones ph ON cl.client_id = ph.client_id
WHERE (first_name = %(first_name)s OR %(first_name)s IS NULL)
AND (last_name = %(last_name)s OR %(last_name)s IS NULL)
AND (email = %(email)s OR %(email)s IS NULL)
AND (phone = %(phone)s OR %(phone)s IS NULL);
”"", {“first_name”: first_name, “last_name”: last_name, “email”: email, “phone”: phone})

# cur.execute("""UPDATE clients 
#                     SET first_name = %s,
#                     last_name = %s,
#                     email = %s
#                     WHERE client_id = %s;
#                     """, (first_name, last_name, email, client_id))
        
#         cur.execute("""UPDATE phone_number
#                     SET phone = %s
#                     WHERE client_id = %s;
#                     """, (phone, client_id))
















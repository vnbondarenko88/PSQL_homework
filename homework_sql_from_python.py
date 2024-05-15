import psycopg2


#  функция создания БД
def create_db(conn):
    with conn.cursor() as cur:

        cur.execute("""
        DROP TABLE clients CASCADE;
        DROP TABLE phone_number CASCADE;
""")
    
        cur.execute("""
                CREATE TABLE IF NOT EXISTS clients (
                    id SERIAL PRIMARY KEY,
                    first_name VARCHAR(30) NOT NULL,
                    last_name VARCHAR(30) NOT NULL,
                    email VARCHAR(60) NULL
                );
""")
        cur.execute("""
                CREATE TABLE IF NOT EXISTS phone_number (
                    id SERIAL PRIMARY KEY,
                    client_id INT NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
                    phone VARCHAR(64) NULL
                );
""")
        conn.commit()

#  Функция, позволяющая добавить нового клиента.
def add_new_client(conn, first_name, last_name, email, phone=None):
    with conn.cursor() as cur:

        cur.execute("""
                INSERT INTO clients (first_name, last_name, email)
                VALUES (%s, %s, %s);
                """, (first_name, last_name, email))
        cur.execute("""
            SELECT * FROM clients;
""")
        conn.commit()
        print(cur.fetchall())

#  Функция, позволяющая добавить телефон для существующего клиента.
def add_phone(conn, client_id, phone):
    with conn.cursor() as cur:

        cur.execute("""
                INSERT INTO phone_number (client_id, phone)
                VALUES (%s, %s);
                """, (client_id, phone))
        cur.execute("""
            SELECT * FROM phone_number
            JOIN clients ON clients.id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())

#  Функция, позволяющая изменить данные о клиенте.
def change_client(conn, first_name=None, last_name=None, email=None, id, client_id, phone=None):
    with conn.cursor() as cur:

        cur.execute("""
                UPDATE clients
                    SET first_name = %s,
                    last_name = %s,
                    email = %s
                    WHERE id = %s;
                """, (first_name, last_name, email, id))
        
        cur.execute("""
                UPDATE phone_number
                    SET client_id = %s,
                    phone = %s
                    WHERE id = %s;
                """, (client_id, phone, id))
        
        cur.execute("""
            SELECT * FROM phone_number
            JOIN clients ON clients.id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())

#  Функция, позволяющая удалить телефон для существующего клиента.
def phone_delete(conn, client_id, phone):
    with conn.cursor() as cur:

        cur.execute("""
                UPDATE phone_number
                SET phone = NULL
                WHERE client_id = %s OR phone = %s;
                """, (client_id, phone))
        cur.execute("""
            SELECT * FROM phone_number
            JOIN clients ON clients.id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())

#  Функция, позволяющая удалить существующего клиента.
def client_delete(conn, client_id):
    with conn.cursor() as cur:

        cur.execute("""
                DELETE FROM clients
                WHERE id IN (SELECT client_id FROM phone_number WHERE client_id = %s);
                """, (client_id,))
        cur.execute("""
            SELECT * FROM phone_number
            JOIN clients ON clients.id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())

#  Функция, позволяющая найти клиента по его данным: имени, фамилии, email или телефону.
def client_find(conn, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:

        cur.execute("""
                SELECT c.first_name, c.last_name, c.email, p.phone
                FROM clients c
                LEFT JOIN phone_number p
                ON c.id = p.client_id
                WHERE c.first_name = %s OR c.last_name = %s OR c.email = %s OR p.phone = %s;
                """, (first_name, last_name, email, phone))
        
        conn.commit()
        print(cur.fetchall())


with psycopg2.connect(database="clients_db", user="postgres", password="v0znLJVA") as conn:
        create_db(conn)
        add_new_client(conn, 'Vadim', 'Bondarenko', 'some@mail.ru')
        add_phone(conn, 1, '89137458965')
        change_client(conn, 'Maria', 'Kopaeva', 'someMK@mail.ru', 1, 1, '89995554473')
        phone_delete(conn, 1, '89995554473')
        client_delete(conn, 1)
        client_find(conn, email='someMK@mail.ru')

conn.close()
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
                    client_id SERIAL PRIMARY KEY,
                    first_name VARCHAR(30) NOT NULL,
                    last_name VARCHAR(30) NOT NULL,
                    email VARCHAR(60) NULL
                );
""")
        cur.execute("""
                CREATE TABLE IF NOT EXISTS phone_number (
                    id SERIAL PRIMARY KEY,
                    client_id INT NOT NULL REFERENCES clients(client_id) ON DELETE CASCADE,
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
            SELECT * FROM clients
            JOIN phone_number ON clients.client_id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())


#  Функция, позволяющая изменить данные о клиенте.
def change_client(conn, client_id, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:

        cur.execute("""
                SELECT * FROM clients c
                JOIN phone_number ph
                ON c.client_id = ph.client_id
                WHERE c.client_id = %s;
                """, (client_id,))
        info = cur.fetchone()
        if first_name is None:
            first_name = info[1]
        if last_name is None:
            last_name = info[2]
        if email is None:
            email = info[3]
        if phone is None:
            phone = info[6]
        cur.execute("""
                UPDATE clients
                SET first_name = %s,
                last_name = %s,
                email = %s
                WHERE client_id = %s;
                """, (first_name, last_name, email, client_id))
        cur.execute("""
                UPDATE phone_number
                SET phone = %s
                WHERE client_id = %s;
                """, (phone, client_id))
        cur.execute("""
            SELECT * FROM clients
            JOIN phone_number ON clients.client_id = phone_number.client_id;
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
            JOIN clients ON clients.client_id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())


#  Функция, позволяющая удалить существующего клиента.
def client_delete(conn, client_id):
    with conn.cursor() as cur:

        cur.execute("""
                DELETE FROM clients
                WHERE client_id IN (SELECT client_id FROM phone_number WHERE client_id = %s);
                """, (client_id,))
        cur.execute("""
            SELECT * FROM phone_number
            JOIN clients ON clients.client_id = phone_number.client_id;
""")
        conn.commit()
        print(cur.fetchall())


#  Функция, позволяющая найти клиента по его данным: имени, фамилии, email или телефону.
def client_find(conn, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:
        cur.execute("""
                SELECT *
                FROM clients cl
                JOIN phone_number ph ON cl.client_id = ph.client_id
                WHERE (first_name = %(first_name)s OR %(first_name)s IS NULL)
                AND (last_name = %(last_name)s OR %(last_name)s IS NULL)
                AND (email = %(email)s OR %(email)s IS NULL)
                AND (phone = %(phone)s OR %(phone)s IS NULL);
                """, {"first_name": first_name, "last_name": last_name, "email": email, "phone": phone})
        conn.commit()
        print(cur.fetchall())


with psycopg2.connect(database="clients_db", user="postgres", password="v0znLJVA") as conn:
    if __name__ == "__main__":
        create_db(conn)
        add_new_client(conn, 'Vadim', 'Bondarenko', 'some@mail.ru')
        add_new_client(conn, 'Maria', 'Kopaeva', 'someMK@mail.ru')
        add_phone(conn, 1, '89137458965')
        add_phone(conn, 2, '89665457587')
        change_client(conn, 1, first_name='Jack', phone='88888888')
        change_client(conn, 2, 'Maria', phone='564562342', email='hgjfjfjf@kakak')
        phone_delete(conn, 1, '88888888')
        client_delete(conn, 1)
        client_find(conn, first_name='Maria', phone='564562342')

conn.close()
import os
import json
import sqlalchemy
from sqlalchemy.orm import sessionmaker
from model_homework import create_table, Publisher, Book, Shop, Stock, Sale

password = os.getenv("MYPASSWORD")
login = os.getenv("MYUSER")
DB_name = os.getenv("DBNAME")

DNS = f'postgresql://{login}:{password}@localhost:5432/{DB_name}'
engine = sqlalchemy.create_engine(DNS)

create_table(engine)
Session = sessionmaker(bind=engine)
session = Session()

with open('fixtures/homework.json', 'r', encoding= 'utf-8') as f:
    json_data = json.load(f)

for record in json_data:
    model = {
        'publisher': Publisher,
        'shop': Shop,
        'book': Book,
        'stock': Stock,
        'sale': Sale,
    }[record.get('model')]
    session.add(model(id=record.get('id'), **record.get('fields')))
session.commit()

result = session.query(Book.title, Shop.name, Sale.price, Sale.date_sale) \
    .join(Publisher) \
    .join(Stock) \
    .join(Shop) \
    .join(Sale)

writer = input('Введите имя автора или его id: ')
if writer.isdigit():
    result = result.filter(Publisher.id == writer).all()
else:
    result = result.filter(Publisher.name == writer).all()
for r in result:
    print(f'{r[0]} | {r[1]} | {r[2]} | {r[3]}')
    

session.close()
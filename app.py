import sqlite3
from flask import Flask, jsonify, request

app = Flask(__name__)
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True


@app.route('/')
def index():
	"""Страница с формой поиска по ID в базе"""
	page = '''
		<form action="/item/">
		<input type=text name="item_id" placeholder="Введите ID животного">
		<input type=submit>
		'''
	return page


@app.route('/item/')
def item():
	"""Вывод найденного животного по его ID в базе"""
	try:
		uid = int(request.args.get('item_id'))
	except (TypeError, ValueError):
		return 'Нужно ввести число'

	with sqlite3.connect('animal.db') as connection:
		cursor = connection.cursor()
	query = '''
		SELECT
		main.id,
		main.animal_id,
		animal_types.type,
		main.name,
		main.date_of_birth,
		breed.breed,
		color_1.color,
		color_2.color,
		os.subtype
		FROM main
		LEFT JOIN animal_types ON main.animal_type = animal_types.id
		LEFT JOIN breed ON main.breed = breed.id
		LEFT JOIN color_1 ON main.color1 = color_1.id
		LEFT JOIN color_2 ON main.color2 = color_2.id
		LEFT JOIN outcome_subtypes os ON main.outcome_subtype = os.id
		LEFT JOIN outcome_types ot ON main.outcome_type = ot.id
		WHERE main.id = :uid
		'''
	cursor.execute(query, {'uid': uid})
	keys = ('id', 'animal_id', 'type', 'name', 'date of birth', 'breed', 'color_1', 'color_2', 'outcome subtype')
	values = cursor.fetchone()
	try:
		return jsonify(dict(zip(keys, values)))
	except TypeError:
		return 'Нет животного с таким ID'


if __name__ == '__main__':
	app.run()

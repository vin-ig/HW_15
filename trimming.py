import sqlite3


def delete_spaces(column):

	query = f'SELECT "index", {column} FROM animals'
	cursor.execute(query)
	result = cursor.fetchall()
	clean_dict = {}
	for row in result:
		try:
			if row[1][-1] == ' ':
				clean_dict[row[0]] = row[1].strip()
		except TypeError:
			continue

	return clean_dict


def write_column(data):
	for key, value in data.items():
		query = f"""
			update animals
			set color1 = '{value}'
			where "index" = {key}
			"""
		cursor.execute(query)


with sqlite3.connect('animal.db') as connection:
	cursor = connection.cursor()
	clean_dict = delete_spaces('color1')
	write_column(clean_dict)


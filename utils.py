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


	query = '''
			create table breeds(
			id integer primary key,
			breed varchar(100) not null
			)'''
	# cursor.execute(query)

	query = '''
			insert into breeds (breed)
			select distinct breed from animals
			'''
	# cursor.execute(query)

	query = '''
			update animals
			set breed = (select id from breeds
			where animals.breed = breeds.breed)
			'''
	# cursor.execute(query)

	query = """
			create table colors(
				id integer primary key autoincrement,
				color varchar(50));
			"""
	# cursor.execute(query)
	


# query = f'''
# 		update animals
# 		set color1 = '{delete_spaces('color1')}'
# 		'''
# # cursor.execute(query)
#
# ########################################
# query = """
# 		insert into colors (color)
# 		select distinct color1 from animals
# 		"""
# # cursor.execute(query)
#
# query = '''
# 		update animals
# 		set breed = (select id from breeds
# 		where animals.breed = breeds.breed)
# 		'''
# # cursor.execute(query)
#
#
#
#
# query = """
# 		SELECT distinct color1, color2 FROM animals
# 		"""
# cursor.execute(query)
#
# # result = [i[0] for i in cursor.execute(query).description]
# result = cursor.fetchall()
# for row in result:
# 	print(*row, sep=' - ')




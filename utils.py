import sqlite3

with sqlite3.connect('D:/Temp/HW_15/animal.db') as connection:
	cursor = connection.cursor()

query = """
		SELECT * FROM animals
		LIMIT 10
		"""
cursor.execute(query)
# result = [i[0] for i in cursor.execute(query).description]
result = cursor.fetchall()

for row in result:
	print(row)
























































































input()
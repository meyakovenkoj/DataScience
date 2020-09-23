import pyodbc
import sys

connection = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};SERVER=mysqlserver1223.database.windows.net,1433;DATABASE=mySampleDatabase;UID={0};PWD={1}'.format(sys.argv[1], sys.argv[0]))

cursor = connection.cursor()

with open(file=sys.argv[1], mode='r') as file:
    querry = file.read()
    cursor.execute(querry)

    rows = cursor.fetchall()
    with open('out_' + sys.argv[1] + '.csv', 'w') as outfile:
        for row in rows:
            for each in row:
                print(each, end=';')
                print(each, end=';', file=outfile)
            print()
            print(file=outfile)
        print('There are {0} rows'.format(len(rows)))

connection.close()

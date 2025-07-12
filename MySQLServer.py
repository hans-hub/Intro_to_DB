import mysql.connector
from mysql.connector import Error

def create_database():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            user = 'root',
            password = '1qaz@WSX'
        )
        cursor = connection.cursor()

        #Try to create a new database
        try:
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database created successfully.")
        except mysql.connector.Error as err:
            print(f"Failed to create database: {err}")


        #Close the cursor and connection
        cursor.close()  
        connection.close()
    except Error as e:
        print(f"Error connecting to MySQL: {err}")
        
        if __name__ == "__main__":
            create_database()
    
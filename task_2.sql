import mysql.connector
from mysql.connector import errorcode

def create_tables():
    TABLES = {}

    TABLES['authors'] = (
        "CREATE TABLE IF NOT EXISTS authors ("
        "  author_id INT AUTO_INCREMENT PRIMARY KEY,"
        "  name VARCHAR(100) NOT NULL,"
        "  bio TEXT"
        ") ENGINE=InnoDB"
    )

    TABLES['books'] = (
        "CREATE TABLE IF NOT EXISTS books ("
        "  book_id INT AUTO_INCREMENT PRIMARY KEY,"
        "  title VARCHAR(255) NOT NULL,"
        "  author_id INT,"
        "  price DECIMAL(10, 2) NOT NULL,"
        "  stock INT NOT NULL,"
        "  FOREIGN KEY (author_id) REFERENCES authors(author_id)"
        ") ENGINE=InnoDB"
    )

    TABLES['customers'] = (
        "CREATE TABLE IF NOT EXISTS customers ("
        "  customer_id INT AUTO_INCREMENT PRIMARY KEY,"
        "  name VARCHAR(100) NOT NULL,"
        "  email VARCHAR(100) UNIQUE NOT NULL,"
        "  address VARCHAR(255)"
        ") ENGINE=InnoDB"
    )

    TABLES['orders'] = (
        "CREATE TABLE IF NOT EXISTS orders ("
        "  order_id INT AUTO_INCREMENT PRIMARY KEY,"
        "  customer_id INT,"
        "  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,"
        "  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)"
        ") ENGINE=InnoDB"
    )

    TABLES['order_details'] = (
        "CREATE TABLE IF NOT EXISTS order_details ("
        "  order_id INT,"
        "  book_id INT,"
        "  quantity INT NOT NULL,"
        "  price DECIMAL(10, 2) NOT NULL,"
        "  PRIMARY KEY (order_id, book_id),"
        "  FOREIGN KEY (order_id) REFERENCES orders(order_id),"
        "  FOREIGN KEY (book_id) REFERENCES books(book_id)"
        ") ENGINE=InnoDB"
    )

    try:
        # Connect to the 'alx_book_store' database
        conn = mysql.connector.connect(
            host="localhost",
            user="your_username",      # Replace with your MySQL username
            password="your_password",  # Replace with your MySQL password
            database="alx_book_store"
        )
        cursor = conn.cursor()

        for table_name, ddl in TABLES.items():
            try:
                cursor.execute(ddl)
                print(f"Table '{table_name}' created successfully!")
            except mysql.connector.Error as err:
                print(f"Error creating table '{table_name}': {err}")

        cursor.close()
        conn.close()

    except mysql.connector.Error as err:
        print(f"Connection failed: {err}")

if __name__ == "__main__":
    create_tables()

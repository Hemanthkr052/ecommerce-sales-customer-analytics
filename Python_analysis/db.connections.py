from sqlalchemy import create_engine, URL, text
from getpass import getpass

# Database credentials
username = input("Enter MySQL username: ")
password = getpass("Enter MySQL password: ")

# Database configuration
connection_url = URL.create(
    drivername="mysql+pymysql",
    username=username,
    password=password,
    host="localhost",
    port=3306,
    database="ecommerce_analytics"
)

# Create database connection
engine = create_engine(connection_url)

# Test connection
try:
    with engine.connect() as connection:
        result = connection.execute(text("SELECT DATABASE()"))
        print("Connected successfully!")
        print("Database:", result.scalar())

except Exception as e:
    print("Connection failed:", e)
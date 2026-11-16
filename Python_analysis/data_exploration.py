import pandas as pd
from sqlalchemy import create_engine, URL
from getpass import getpass

# Connect to MySQL
username = input("Enter MySQL username: ")
password = getpass("Enter MySQL password: ")

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=username,
    password=password,
    host="localhost",
    port=3306,
    database="ecommerce_analytics"
)

engine = create_engine(connection_url)

# Load complete orders table
query = "SELECT * FROM orders"

orders_df = pd.read_sql(query, engine)

# 1. Display first 5 rows
print("\nFIRST 5 ROWS:")
print(orders_df.head())

# 2. Display number of rows and columns
print("\nDATASET SHAPE:")
print(orders_df.shape)

# 3. Display column names and data types
print("\nDATASET INFORMATION:")
orders_df.info()

# 4. Check missing values
print("\nMISSING VALUES:")
print(orders_df.isnull().sum())

# 5. Display statistical summary
print("\nSTATISTICAL SUMMARY:")
print(orders_df.describe(include="all"))
import pandas as pd
from sqlalchemy import create_engine, URL
from getpass import getpass

# Database credentials
username = input("Enter MySQL username: ")
password = getpass("Enter MySQL password: ")

# Create database connection
connection_url = URL.create(
    drivername="mysql+pymysql",
    username=username,
    password=password,
    host="localhost",
    port=3306,
    database="ecommerce_analytics"
)

engine = create_engine(connection_url)

# Load orders data
query = """
SELECT *
FROM orders
LIMIT 10
"""

orders_df = pd.read_sql(query, engine)

# Display data
print("\nFirst 10 orders:")
print(orders_df)

# Display dataset information
print("\nDataset shape:")
print(orders_df.shape)

print("\nColumn names:")
print(orders_df.columns.tolist())
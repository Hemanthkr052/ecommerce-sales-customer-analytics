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

# Load orders table
orders_df = pd.read_sql("SELECT * FROM orders", engine)

# 1. Check duplicate orders
print("\nDuplicate order IDs:")
print(orders_df["order_id"].duplicated().sum())

# 2. Check missing values
print("\nMissing values:")
print(orders_df.isnull().sum())

# 3. Convert date columns into datetime format
date_columns = [
    "order_purchase_timestamp",
    "order_approved_at",
    "order_delivered_carrier_date",
    "order_delivered_customer_date",
    "order_estimated_delivery_date"
]

for column in date_columns:
    orders_df[column] = pd.to_datetime(orders_df[column])

# 4. Create delivery duration column
orders_df["delivery_days"] = (
    orders_df["order_delivered_customer_date"]
    - orders_df["order_purchase_timestamp"]
).dt.days

# 5. Display cleaned data information
print("\nUpdated data types:")
print(orders_df.dtypes)

print("\nDelivery duration:")
print(orders_df[["order_status", "delivery_days"]].head(10))

# 6. Save cleaned dataset
orders_df.to_csv(
    "Python_analysis/cleaned_orders.csv",
    index=False
)

print("\nCleaned dataset saved successfully!")
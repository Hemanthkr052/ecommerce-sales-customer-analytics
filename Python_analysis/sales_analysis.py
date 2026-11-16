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

# Load delivered order sales data
query = """
SELECT
    o.order_id,
    o.order_purchase_timestamp,
    oi.price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
"""

sales_df = pd.read_sql(query, engine)

# Convert timestamp into datetime
sales_df["order_purchase_timestamp"] = pd.to_datetime(
    sales_df["order_purchase_timestamp"]
)

# Calculate business KPIs
total_revenue = sales_df["price"].sum()
total_orders = sales_df["order_id"].nunique()
average_order_value = total_revenue / total_orders

print("\nSALES PERFORMANCE")
print("-------------------------")
print("Total Revenue: R$", round(total_revenue, 2))
print("Total Orders:", total_orders)
print("Average Order Value: R$", round(average_order_value, 2))

# Monthly revenue analysis
sales_df["month"] = (
    sales_df["order_purchase_timestamp"].dt.to_period("M")
)

monthly_revenue = (
    sales_df.groupby("month")["price"]
    .sum()
    .reset_index()
)

print("\nMONTHLY REVENUE")
print(monthly_revenue.to_string(index=False))

# Save monthly analysis
monthly_revenue.to_csv(
    "Python_analysis/monthly_revenue.csv",
    index=False
)

print("\nMonthly sales analysis saved successfully!")
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

# Load customer purchase data
query = """
SELECT
    c.customer_unique_id,
    o.order_id,
    oi.price
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
"""

customer_df = pd.read_sql(query, engine)

# Calculate customer-level metrics
customer_summary = (
    customer_df.groupby("customer_unique_id")
    .agg(
        total_orders=("order_id", "nunique"),
        total_revenue=("price", "sum")
    )
    .reset_index()
)

# Calculate KPIs
total_customers = len(customer_summary)

repeat_customers = (
    customer_summary["total_orders"] > 1
).sum()

repeat_rate = (repeat_customers / total_customers) * 100

average_customer_revenue = (
    customer_summary["total_revenue"].mean()
)

# Display results
print("\nCUSTOMER BEHAVIOUR ANALYSIS")
print("-----------------------------")

print("Total Customers:", total_customers)
print("Repeat Customers:", repeat_customers)
print("One-time Customers:", total_customers - repeat_customers)

print("Repeat Purchase Rate:", round(repeat_rate, 2), "%")

print(
    "Average Customer Revenue: R$",
    round(average_customer_revenue, 2)
)

# Identify top 10 customers
top_customers = customer_summary.sort_values(
    by="total_revenue",
    ascending=False
).head(10)

print("\nTOP 10 CUSTOMERS BY REVENUE")
print(top_customers.to_string(index=False))

# Save customer analysis
customer_summary.to_csv(
    "Python_analysis/customer_analysis.csv",
    index=False
)

print("\nCustomer analysis saved successfully!")
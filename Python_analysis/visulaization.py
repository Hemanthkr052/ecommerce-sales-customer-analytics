import pandas as pd
import matplotlib.pyplot as plt
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

# --------------------------------
# CHART 1: MONTHLY REVENUE TREND
# --------------------------------

monthly_revenue = pd.read_csv(
    "Python_analysis/monthly_revenue.csv"
)

monthly_revenue["month"] = pd.to_datetime(
    monthly_revenue["month"].astype(str)
)

plt.figure(figsize=(12, 6))

plt.plot(
    monthly_revenue["month"],
    monthly_revenue["price"],
    marker="o"
)

plt.title("Monthly Revenue Trend")
plt.xlabel("Month")
plt.ylabel("Revenue (BRL)")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig("Python_analysis/monthly_revenue.png")
plt.show()


# --------------------------------
# CHART 2: TOP 10 PRODUCT CATEGORIES
# --------------------------------

query = """
SELECT
    ct.product_category_name_english AS category,
    SUM(oi.price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY ct.product_category_name_english
ORDER BY revenue DESC
LIMIT 10
"""

category_df = pd.read_sql(query, engine)

plt.figure(figsize=(10, 6))

plt.barh(
    category_df["category"],
    category_df["revenue"]
)

plt.title("Top 10 Product Categories by Revenue")
plt.xlabel("Revenue (BRL)")
plt.ylabel("Product Category")
plt.gca().invert_yaxis()
plt.tight_layout()

plt.savefig("Python_analysis/top_10_categories.png")
plt.show()

print("Both visualizations created successfully!")
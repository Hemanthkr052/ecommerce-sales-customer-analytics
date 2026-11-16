import pandas as pd
import matplotlib.pyplot as plt

# Load customer analysis data
customer_df = pd.read_csv(
    "Python_analysis/customer_analysis.csv"
)

# --------------------------------
# CHART 1: ONE-TIME VS REPEAT CUSTOMERS
# --------------------------------

repeat_customers = (
    customer_df["total_orders"] > 1
).sum()

one_time_customers = (
    customer_df["total_orders"] == 1
).sum()

labels = ["One-time Customers", "Repeat Customers"]

values = [one_time_customers, repeat_customers]

plt.figure(figsize=(8, 6))

plt.pie(
    values,
    labels=labels,
    autopct="%1.2f%%",
    startangle=90
)

plt.title("One-time vs Repeat Customers")
plt.tight_layout()

plt.savefig(
    "Python_analysis/customer_distribution.png"
)

plt.show()


# --------------------------------
# CHART 2: TOP 10 CUSTOMERS BY REVENUE
# --------------------------------

top_customers = customer_df.sort_values(
    by="total_revenue",
    ascending=False
).head(10)

plt.figure(figsize=(10, 6))

plt.barh(
    top_customers["customer_unique_id"].astype(str),
    top_customers["total_revenue"]
)

plt.title("Top 10 Customers by Revenue")
plt.xlabel("Revenue (BRL)")
plt.ylabel("Customer ID")

plt.gca().invert_yaxis()

plt.tight_layout()

plt.savefig(
    "Python_analysis/top_10_customers.png"
)

plt.show()

print("Customer visualizations created successfully!")
import pandas as pd

# Load analysis datasets
monthly_df = pd.read_csv(
    "Python_analysis/monthly_revenue.csv"
)

customer_df = pd.read_csv(
    "Python_analysis/customer_analysis.csv"
)

# --------------------------------
# 1. SALES INSIGHTS
# --------------------------------

total_revenue = monthly_df["price"].sum()

average_monthly_revenue = monthly_df["price"].mean()

best_month = monthly_df.loc[
    monthly_df["price"].idxmax()
]

print("\n========== SALES INSIGHTS ==========")

print("Total Revenue: R$", round(total_revenue, 2))

print(
    "Average Monthly Revenue: R$",
    round(average_monthly_revenue, 2)
)

print(
    "Highest Revenue Month:",
    best_month["month"]
)

print(
    "Highest Monthly Revenue: R$",
    round(best_month["price"], 2)
)

# --------------------------------
# 2. CUSTOMER INSIGHTS
# --------------------------------

total_customers = len(customer_df)

repeat_customers = (
    customer_df["total_orders"] > 1
).sum()

one_time_customers = (
    customer_df["total_orders"] == 1
).sum()

repeat_rate = (
    repeat_customers / total_customers
) * 100

print("\n========== CUSTOMER INSIGHTS ==========")

print("Total Customers:", total_customers)

print("One-time Customers:", one_time_customers)

print("Repeat Customers:", repeat_customers)

print("Repeat Purchase Rate:", round(repeat_rate, 2), "%")

# --------------------------------
# 3. BUSINESS RECOMMENDATIONS
# --------------------------------

print("\n========== BUSINESS RECOMMENDATIONS ==========")

print("1. Improve customer retention through loyalty programs.")

print("2. Investigate why repeat purchases are relatively low.")

print("3. Study high-revenue months to understand sales patterns.")

print("4. Develop targeted campaigns for high-value customers.")

print("\nBusiness insights generated successfully!")
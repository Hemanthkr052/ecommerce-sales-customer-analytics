# E-Commerce Sales & Customer Behaviour Analytics

## Project Overview

This project analyses Brazilian e-commerce transactions using the Olist dataset to identify sales trends, customer purchasing behaviour, product performance, payment patterns, and delivery performance.

The objective is to transform raw transactional data into meaningful business insights using SQL, Python, and Power BI.

## Tools & Technologies

- MySQL – Data storage, querying, and analysis
- Python – Data cleaning and analysis
- Pandas and NumPy – Data manipulation
- Matplotlib and Seaborn – Data visualization
- Power BI – Interactive dashboards
- VS Code – Python development

## Project Objectives

1. Analyse overall sales and revenue performance.
2. Identify top-performing product categories and sellers.
3. Understand customer purchasing and repeat purchase behaviour.
4. Analyse payment methods and installment patterns.
5. Evaluate delivery performance and customer reviews.
6. Perform RFM-based customer segmentation.

## Key Business Findings

- Total delivered revenue: R$13.22 million.
- Total delivered orders: 96,478.
- Average order value: R$137.04.
- Total customers: 93,358.
- Repeat customers: 2,801.
- Repeat purchase rate: 3.00%.
- Health & Beauty generated the highest category revenue.
- November 2017 recorded the highest monthly revenue.
- Late deliveries received lower average review scores than on-time deliveries.

## Business Recommendations

1. Introduce customer loyalty programs to encourage repeat purchases.
2. Develop targeted marketing campaigns for high-value customers.
3. Investigate delivery delays and improve logistics performance.
4. Monitor product categories with high negative review rates.
5. Study seasonal sales patterns to improve business planning.

## Project Structure

```text
ecommerce-sales-customer-analytics/
├── SQL_analysis/
│   ├── customer_analysis.sql
│   ├── delivery_analysis.sql
│   ├── payment_analysis.sql
│   ├── product_analysis.sql
│   ├── review_analysis.sql
│   ├── rfm_analysis.sql
│   ├── sales_analysis.sql
│   └── seller_analysis.sql
├── Python_analysis/
│   ├── data_loading.py
│   ├── data_cleaning.py
│   ├── data_exploration.py
│   ├── sales_analysis.py
│   ├── customer_analysis.py
│   ├── business_insights.py
│   ├── visualization scripts
│   └── charts
├── PowerBI/
│   └── Ecommerce_Sales_Customer_Analytics.pbix
├── Screenshots/
│   ├── Customer Analysis Dashboard.png
│   ├── Delivery and Reviews.png
│   ├── Executive Overview.png
│   └── Product and Seller Analysis.png
├── .gitignore
├── requirements.txt
└── Readme.md

```


## Power BI Dashboard Preview

### 1. Executive Overview
![Executive Overview](Screenshots/Executive%20Overview.png)

### 2. Product & Seller Analysis
![Product and Seller Analysis](Screenshots/Product%20and%20Seller%20Analysis.png)

### 3. Customer Analysis
![Customer Analysis](Screenshots/Customer%20Analysis%20Dashboard.png)

### 4. Delivery & Reviews
![Delivery and Reviews](Screenshots/Delivery%20and%20Reviews.png)
## Conclusion

This project demonstrates an end-to-end data analytics workflow, from relational database analysis and Python-based exploration to interactive dashboard development.

The findings provide insights that can support data-driven decisions related to revenue growth, customer retention, product performance, and delivery operations.
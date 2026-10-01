# E-commerce Supply Chain & Order Performance Analytics

An end-to-end data engineering and business intelligence project analyzing the Brazilian E-commerce dataset. This project tracks supply chain efficiency, isolates fulfillment bottlenecks, measures delivery delays, and correlates shipping performance with customer satisfaction ratings.

---

## 📊 Project Overview

In modern e-commerce, delivery speed and reliability directly dictate customer retention and brand loyalty. This project simulates an operational supply chain analytics workflow designed to answer critical business questions:

* *Where are the primary regional delivery bottlenecks occurring?*
* Which sellers introduce the highest fulfillment and processing delays?


* To what extent do late deliveries damage customer review scores and brand perception?



---

## 🏗️ Architecture & Data Pipeline

The project is built using a robust PostgreSQL relational pipeline that transforms raw transactional data into clean analytical structures:

1. **Staging Layer (`staging.*`):** Ingests raw data across 8 tables including customers, sellers, products, order items, payments, and reviews.


2. **Fact Transformation (`fact_orders`):** Merges order details with item aggregates and review scores while engineering vital performance flags like `is_late`, `processing_days`, and `shipping_days`.



---

## 🛠️ Tech Stack & Tools

* **Database & Querying:** PostgreSQL (Data modeling, CTEs, window functions, and staging transformations)
* **Data Visualization & Modeling:** Power BI Desktop
* **Calculations:** DAX (Data Analysis Expressions for custom KPIs and rate metrics)
* **Version Control:** Git & GitHub

---

## 📈 Key Analytical Queries & Insights

The repository includes pre-built analytical scripts answering core supply chain questions:

* **Regional Late Delivery Breakdown:** Filters customer states with significant order volume ($\ge 500$ orders) to rank regions by late delivery percentages.


* **Seller Bottlenecks:** Analyzes seller-level fulfillment data ($\ge 50$ orders) to identify average processing delays and pinpoint underperforming suppliers.


* **Satisfaction Correlation:** Examines the direct statistical relationship between late shipment statuses and poor review ratings ($\le 2$ stars).



---

## 🚀 DAX Measures Highlights

Key metrics implemented in Power BI to monitor operational health:

```dax
-- Calculates the percentage of delayed shipments safely
Late Delivery Pct = DIVIDE([Late Orders], [Total Orders], 0)

-- Identifies the proportion of orders resulting in a poor customer rating (2 stars or lower)
Poor Review Pct = 
DIVIDE(
    CALCULATE(COUNTROWS('fact_orders'), 'fact_orders'[avg_review_score] <= 2),
    [Total Orders],
    0
)

```

---

## 📁 Repository Structure

```text
├── databases/
│   ├── staging.sql              -- Raw database schema setup
│   └── fact_orders.sql          -- Fact table transformation pipeline
├── queries/
│   ├── regional_analysis.sql    -- State-level late delivery breakdown
│   ├── seller_bottlenecks.sql   -- Seller fulfillment latency tracking
│   └── review_correlation.sql   -- Delivery status vs. customer rating impact
└── dax/
    └── ecommerce_measures.dax   -- Power BI DAX calculation models

```

---

## 💡 How to Explore This Project

1. **Clone the repository:**
```bash
git clone https://github.com/jawhor-ali/ecommerce-supply-chain-analytics.git

```


2. **Run Database Scripts:** Execute `staging.sql` followed by `fact_orders.sql` in your PostgreSQL environment to build the pipeline.


3. **Explore Analytics:** Run the queries provided in the `queries/` directory to extract operational insights.

---

## 👤 Author

**Jawhor Ali Khan**

*Aspiring Business Analyst / Data Professional*

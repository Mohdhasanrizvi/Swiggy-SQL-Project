# Swiggy-SQL-Project
# 🛵 Swiggy Data Analysis using SQL

This project analyzes food delivery trends from a Swiggy dataset using **MySQL**. It simulates a real-world scenario where data analysts help restaurant owners make business decisions based on food type popularity, pricing, customer ratings, delivery time, and geography.

---

## 📊 Project Type
**💡 SQL-Based Data Analysis Project**

- Database: MySQL  
- Dataset: `swiggy.csv`  
- Focus: Business insight extraction via SQL queries  
- Optional: Python or Excel can be used for data visualization

---

## 📁 Dataset Overview

| Column Name     | Description                             |
|------------------|-----------------------------------------|
| `ID`             | Unique ID per restaurant                |
| `Restaurant`     | Name of the restaurant                  |
| `Area`           | Local area of the restaurant            |
| `City`           | City where the restaurant is located    |
| `Price`          | Average order price (₹)                 |
| `Avg_ratings`    | Average customer rating                 |
| `Total_ratings`  | Total number of ratings (proxy for orders) |
| `Food_type`      | Comma-separated list of cuisines        |
| `Address`        | Full address                            |
| `Delivery_time`  | Estimated delivery time (in minutes)    |

---

## 🧠 Business Questions Answered (in SQL)

1. **Top 5 food types** based on popularity and average price  
2. **Best areas/cities** to open a new restaurant (based on customer engagement)  
3. **Suggested operational hours** based on delivery patterns  
4. **High-margin cuisine suggestions** based on average order value  
5. **Seasonal or trending food items**  
6. **Price range and rating benchmarks** for competitive positioning

---

## 🛠️ SQL Techniques Used

- `GROUP BY`, `ORDER BY`, `LIMIT`
- `AVG()`, `COUNT()`, `ROUND()`
- `SUBSTRING_INDEX()` and `TRIM()` for splitting comma-separated values
- `WHERE`, `UNION ALL` for row-wise food type explosion
- Joins and filtering for location/rating insights

---

## 📌 Sample Query (Top 5 Individual Food Types)

```sql
SELECT 
  LOWER(TRIM(food)) AS Food_Type,
  COUNT(*) AS Frequency,
  ROUND(AVG(Price), 0) AS Avg_Price,
  ROUND(AVG(Total_ratings), 0) AS Avg_Total_Ratings
FROM (
  SELECT TRIM(SUBSTRING_INDEX(Food_type, ',', 1)) AS food, Price, Total_ratings FROM swiggy
  UNION ALL
  SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Food_type, ',', 2), ',', -1)), Price, Total_ratings FROM swiggy
  UNION ALL
  SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Food_type, ',', 3), ',', -1)), Price, Total_ratings FROM swiggy
) AS exploded
GROUP BY LOWER(TRIM(food))
ORDER BY Avg_Total_Ratings DESC, Frequency DESC
LIMIT 5;

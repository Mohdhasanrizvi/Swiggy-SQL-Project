-- Ques 1) Suggest me the top 5 food type with most selling and max margin and also suggest its price range?

SELECT 
  food AS Food_Type,
  COUNT(*) AS Frequency,
  ROUND(AVG(Price), 2) AS Avg_Price,
  ROUND(AVG(Total_ratings), 1) AS Avg_Total_Ratings
FROM (
  SELECT 
    TRIM(SUBSTRING_INDEX(Food_type, ',', 1)) AS food,
    Price,
    Total_ratings
  FROM swiggy
  WHERE Food_type IS NOT NULL

  UNION ALL

  SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Food_type, ',', 2), ',', -1)) AS food,
    Price,
    Total_ratings
  FROM swiggy
  WHERE Food_type LIKE '%,%'

  UNION ALL

  SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Food_type, ',', 3), ',', -1)) AS food,
    Price,
    Total_ratings
  FROM swiggy
  WHERE Food_type LIKE '%,%,%'
) AS exploded
GROUP BY food
ORDER BY Avg_Total_Ratings DESC, Frequency DESC
LIMIT 5;

-- Ques 2) Suggest me the location?

SELECT 
  Area,
  ROUND(AVG(Total_ratings), 1) AS Avg_Ratings,
  COUNT(*) AS Restaurant_Count
FROM swiggy
GROUP BY Area
ORDER BY Avg_Ratings DESC, Restaurant_Count DESC
LIMIT 5;

-- Ques 3) Suggest me the timing of operation?

SELECT ROUND(AVG(Delivery_time), 1) AS Avg_Delivery_Minutes
FROM swiggy;

-- Ques 4) And any 2 additional seasonal items?

SELECT 
  food,
  COUNT(*) AS Frequency
FROM (
  SELECT 
    TRIM(SUBSTRING_INDEX(Food_type, ',', 1)) AS food
  FROM swiggy WHERE Food_type IS NOT NULL

  UNION ALL

  SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Food_type, ',', 2), ',', -1)) AS food
  FROM swiggy WHERE Food_type LIKE '%,%'

  UNION ALL

  SELECT 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Food_type, ',', 3), ',', -1)) AS food
  FROM swiggy WHERE Food_type LIKE '%,%,%'
) AS exploded
GROUP BY food
ORDER BY Frequency DESC
LIMIT 10;

CREATE TABLE IF NOT EXISTS sales(
invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
branch VARCHAR(5) NOT NULL, 
city VARCHAR(30) NOT NULL,
customer_type VARCHAR(30) NOT NULL,
gender VARCHAR(10) NOT NULL,
product_line VARCHAR(100) NOT NULL,
unit_price DECIMAL(10,2) NOT NULL,
quantity INT NOT NULL,
VAT FLOAT(6,4) NOT NULL,
total DECIMAL(12,4) NOT NULL,
date DATETIME NOT NULL,
time TIME NOT NULL,
payment_method VARCHAR(15) NOT NULL,
cogs DECIMAL(10,2) NOT NULL,
gross_income DECIMAL(12,4) NOT NULL,
rating FLOAT(2,1) );

UPDATE sales 
SET cITY = city ; 

--------------------------------------------------------------------------------------------------------------------
---------------------------------FEATURE ENGINEERING---------------------------------------------------------------

-- time of day

SELECT 
   time,
      (CASE 
          WHEN 'time' BETWEEN "00:00:00" AND "12:00:00"
          THEN "MORNING"
          WHEN 'time' BETWEEN "12:00:00" AND "16:00:00"
          THEN "AFTERNOON"
          ELSE "EVENING"
          END
          )AS time_of_day
          FROM sales;
          
          ALTER TABLE sales ADD COLUMN time_of_day VARCHAR (20);
          
          UPDATE 	sales 
          SET time_of_day =
          (CASE 
          WHEN 'time' BETWEEN "00:00:00" AND "12:00:00"
          THEN "MORNING"
          WHEN 'time' BETWEEN "12:00:00" AND "16:00:00"
          THEN "AFTERNOON"
          ELSE "EVENING"
          END ) ;
        
-- day_name

SELECT
      date,
       DAYNAME (date) AS day_name 
       FROM sales;
       
 ALTER TABLE sales ADD COLUMN day_name VARCHAR (10);
 UPDATE sales 
 SET day_name = DAYNAME (date); 
 
 -- monthy_name
 
 SELECT 
     date,
     MONTHNAME(date)
  FROM sales ;
  ALTER TABLE sales ADD COLUMN month_name VARCHAR (10);
  UPDATE sales 
  SET month_nam,e = MONTHNAME (date);

-------------------------------------GENERIC---------------------------------
-- HOW MANY UNIQUE CITIES DOES THE DATA HAVE?

SELECT 
     DISTINCT cITY  
     from sales;
     
-- In which city is each branch?

SELECT 
    DISTINCT cITY,
     branch
     FROM sales;
     
----------------------------PRODUCT----------------------------------------------

-- How many unique product lines does the data have ?

SELECT 
   COUNT(DISTINCT product_line)
   FROM sales ;
   
-- What is the most common payment method?

SELECT payment_method ,COUNT(payment_method) AS cnt
  FROM sales 
  GROUP BY payment_method
  ORDER BY cnt DESC;
  
-- What is the most selling product line?

SELECT product_line,
		COUNT(product_line) as cnt
  FROM sales
  group by product_line
  order by cnt DESC ;
  
  -- WHAT IS THE TOTAL REVENUE BY MONTH ?
  
  SELECT 
    month_name AS month, SUM(total) AS total_revenue
FROM
    sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- WHAT MONTH HAD THE LARGEST COGS?

SELECT 
    month_name AS month, SUM(COGS) AS cogs
FROM
    sales
GROUP BY month_name
ORDER BY cogs;

-- WHICH BRAND SOLD MORE PRODUCTS THAN AVERAGE PRODUCT SOLD?
SELECT branch ,
SUM(quantity) AS qty 
From sales 
group by branch
having SUM(quantity)>(SELECT AVG (quantity ) 
from sales);

-- whatv is the most common product_line by gender?
SELECT 
gender ,
product_line,
COUNT(gender) AS total_cnt 
FROM sales 
GROUP BY  gender, product_line
order by total_cnt DESC;

-- WHAT IS THE AVERAGE RATING OF EACH product_line ?

SELECT ROUND(AVG(rating)) AS avg_rating,
product_line
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;

------------------------------------ ----SALES-------------------------------------------------------
--------------------------------------------------------------------------------------------------
 
 -- WHAT is the b numeber of sales made in each time of the day per weekday?
 
 SELECT time_of_day, COUNT(*) AS total_sales FROM sales WHERE day_name = "SUNDAY"
 GROUP BY time_of_day 
 ORDER BY  total_sales DESC; 
 
 -- WHICH OF THE CUSTOMER TYPES BRING THE MOST REVENUE ?
 
  SELECT 
    customer_type, SUM(total) AS total_rev
FROM
    sales
GROUP BY customer_type
ORDER BY total_rev DESC;

-- WHICH CITY HAS THE LARGEST TAX PERCENT/VAT ?

SELECT CITY, AVG(VAT ) AS VAT 
 FROM sales 
 GROUP BY  city 
 ORDER BY VAT DESC;
 
 -- WHICH CUSTOMER TYPE PAYS THE MOST IN VAT?
 
 SELECT customer_type ,
 AVG(VAT) AS VAT 
 FROM sales GROUP BY customer_type 
 ORDER BY VAT DESC ;
 
 -------------------------------------------- CUSTOMER -----------------------------------------
-------------------------------------------------------------------------------------------------------

-- HOW AMNY UNIQUE CUSTOMER TYPES DOES THE DATA HAVE?

SELECT 
     DISTINCT customer_type
     FROM sales ;
     
-- HOW MANY UNIQUE PAYMENT METHODS DOES THYE DATA HAVE ?

SELECT DISTINCT payment_method
FROM sales ;

-- WHICH CUSTOMER TYPE BUYS THE MOST ?

 SELECT 
    customer_type, COUNT(*) AS custm_cnt
FROM
    sales
GROUP BY customer_type;

-- WHAT IS THE GENDER OF THE MOST OF THE CUSTOMERS?

SELECT 
    gender, COUNT(*) AS gender_cnt
FROM
    sales
GROUP BY gender
ORDER BY gender_cnt DESC;

-- WHAT IS THE GENDER DISTRIBUTION PER BRANCH ?
-- 
SELECT gender,COUNT(*) AS gender_cnt 
FROM sales WHERE branch = "C" OR "A" OR "B"
GROUP BY gender
ORDER BY gender_cnt DESC;

-- WHAT TIME OF THE DAY DO CUSTOMERS GIVE MOST RATINGS PER BRANCH ?

 SELECT  time_of_day, AVG(rating ) AS avg_rating
 from sales 
 where branch ="A"
 GROUP BY time_of_day 
 ORDER  BY avg_rating DESC ;
 
-- WHICH DAY OF THE WEEK HAS THE BEST AVG RATING ?

 SELECT 
 day_name , AVG (rating) AS  avg_rating 
 FROM sales 
 group by day_name 
 order by avg_rating DESC;


New File at / · Diwakar15aeco/wallmart-sql-project

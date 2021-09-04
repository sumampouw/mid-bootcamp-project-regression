-- SQL questions - regression
-- 1. Create a database called `house_price_regression`. (ok)
-- 2. Create a table `house_price_data` with the same columns as given in the csv file. (ok)
-- 3. Import the data from the csv file into the table. (ok)

-- 4. Select all the data from table house_price_data to check if the data was imported correctly
SELECT * 
FROM house_price_regression.house_price_data;

-- 5. Use the alter table command to drop the column `date` from the database, as we would not use it in the analysis with SQL (ok). Select all the data from the table to verify if the command worked. Limit your returned results to 10.
SELECT * 
FROM house_price_regression.house_price_data
LIMIT 10;

-- 6. Use sql query to find how many rows of data you have.
SELECT COUNT(*)
FROM house_price_regression.house_price_data;

-- 7. try to find the unique values in some of the categorical columns
-- What are the unique values in the column `bedrooms`?
SELECT DISTINCT bedrooms
FROM house_price_regression.house_price_data;
-- What are the unique values in the column `bathrooms`?
SELECT DISTINCT bathrooms
FROM house_price_regression.house_price_data;
-- What are the unique values in the column `floors`?
SELECT DISTINCT floors
FROM house_price_regression.house_price_data;
-- What are the unique values in the column `condition`?
SELECT DISTINCT house_price_data.condition
FROM house_price_regression.house_price_data;
-- What are the unique values in the column `grade`?
SELECT DISTINCT grade
FROM house_price_regression.house_price_data;

-- 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
SELECT id
FROM house_price_regression.house_price_data
ORDER BY price DESC
LIMIT 10;

-- 9. What is the average price of all the properties in your data?
SELECT AVG(price)
FROM house_price_regression.house_price_data;

-- 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
-- What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
SELECT bedrooms, AVG(price) AS avg_price_bedrooms
FROM house_price_regression.house_price_data
GROUP BY bedrooms;
-- What is the average `sqft_living` of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the `sqft_living`. Use an alias to change the name of the second column.
SELECT bedrooms, AVG(sqft_living) AS avg_sqft_living
FROM house_price_regression.house_price_data
GROUP BY bedrooms;
-- What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and `Average` of the prices. Use an alias to change the name of the second column.
SELECT waterfront, AVG(price) AS avg_price_waterfront
FROM house_price_regression.house_price_data
GROUP BY waterfront;
-- Is there any correlation between the columns `condition` and `grade`? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
SELECT house_price_data.condition, grade, AVG(price) AS avg_price
FROM house_price_regression.house_price_data
GROUP BY house_price_data.condition, grade
ORDER BY 3 DESC, 2 DESC, 1 DESC;

-- 11. One of the customers is only interested in the following houses:
    -- Number of bedrooms either 3 or 4
    -- Bathrooms more than 3
    -- One Floor
    -- No waterfront
    -- Condition should be 3 at least
    -- Grade should be 5 at least
    -- Price less than 300000
SELECT bedrooms, bathrooms, floors, waterfront, house_price_data.condition, grade, price
FROM house_price_regression.house_price_data
WHERE 	(bedrooms = 3 OR bedrooms = 4) AND
		bathrooms >= 3 AND
        floors = 1 AND
        waterfront = 0 AND
        house_price_data.condition >= 3 AND
        grade >= 5 AND
        price < 300000
ORDER BY 7 DESC;

-- 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database
SELECT *
FROM house_price_regression.house_price_data
HAVING price > (SELECT AVG(price) FROM house_price_regression.house_price_data);

-- 13. Since this is something that the senior management is regularly interested in, create a view called Houses_with_higher_than_double_average_price of the same query.
CREATE VIEW `Houses_with_higher_than_double_average_price` AS
SELECT *
FROM house_price_regression.house_price_data
HAVING price > (SELECT AVG(price) FROM house_price_regression.house_price_data);

-- 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
-- Answer: there are no much difference in prices, it is more into preferences
SELECT bedrooms, house_price_data.condition, grade, AVG(price) AS avg_price
FROM house_price_regression.house_price_data
WHERE bedrooms = 3 OR bedrooms = 4
GROUP BY bedrooms, house_price_data.condition, grade
ORDER BY 4 DESC;

-- 15. What are the different locations where properties are available in your database? (distinct zip codes)
SELECT DISTINCT zipcode
FROM house_price_regression.house_price_data;

-- 16. Show the list of all the properties that were renovated.
SELECT *
FROM house_price_regression.house_price_data
WHERE yr_renovated > 0;

-- 17. Provide the details of the property that is the 11th most expensive property in your database.
SELECT *
FROM house_price_regression.house_price_data
ORDER BY price DESC
LIMIT 11;

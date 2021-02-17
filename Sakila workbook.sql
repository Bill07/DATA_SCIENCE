
-- Write a query to find the full name of the actor who has acted in the maximum number of movies.
-- without using the concat() function

use Sakila;

set sql_mode=PIPES_AS_CONCAT;
SELECT FIRST_NAME || ' ' || LAST_NAME AS Full_name
FROM ACTOR INNER JOIN FILM_ACTOR using(ACTOR_ID)
GROUP BY Full_name
ORDER BY COUNT(FILM_ID) DESC
LIMIT 1;


-- Write a query to find the full name of the actor who has acted in the third most number of movies.

SELECT FIRST_NAME || ' ' || LAST_NAME AS Actor_name
FROM ACTOR INNER JOIN FILM_ACTOR using(ACTOR_ID)
GROUP BY Actor_name
ORDER BY COUNT(FILM_ID) DESC
LIMIT 2, 1; #offset 2, return next 1


-- Write a query to find the film which grossed the highest revenue for the video renting organisation.

SELECT TITLE as title FROM 
FILM f LEFT JOIN INVENTORY i using(FILM_ID)
LEFT JOIN RENTAL r using(INVENTORY_ID)
LEFT JOIN PAYMENT p using(RENTAL_ID)
GROUP BY TITLE
ORDER BY sum(AMOUNT) DESC
LIMIT 1;


-- Write a query to find the city which generated the maximum revenue for the organisation.
SELECT CITY as city FROM 
CITY c LEFT JOIN ADDRESS ad using(CITY_ID)
LEFT JOIN CUSTOMER cus using(ADDRESS_ID)
LEFT JOIN PAYMENT p using(CUSTOMER_ID)
GROUP BY city
ORDER BY sum(AMOUNT) DESC
LIMIT 1;


-- Write a query to find out how many times a particular movie category is rented. 
-- Arrange these categories in the decreasing order of the number of times they are rented.

SELECT c.NAME AS Name, count(r.RENTAL_ID) AS Rental_count FROM 
CATEGORY c INNER JOIN FILM_CATEGORY fc using(CATEGORY_ID)
INNER JOIN FILM f using(FILM_ID)
INNER JOIN INVENTORY i using(FILM_ID)
INNER JOIN RENTAL r using(INVENTORY_ID)
GROUP BY c.Name
ORDER BY count(r.RENTAL_ID) DESC;



-- Write a query to find the full names of customers who have rented sci-fi movies more than 2 times. 
-- Arrange these names in the alphabetical order.

SELECT FIRST_NAME || ' ' || LAST_NAME AS Customer_name
FROM CATEGORY c LEFT JOIN FILM_CATEGORY fc using(CATEGORY_ID)
LEFT JOIN FILM f using(FILM_ID)
LEFT JOIN INVENTORY i using(FILM_ID)
LEFT JOIN RENTAL r using(INVENTORY_ID)
LEFT JOIN CUSTOMER cus using(CUSTOMER_ID)
WHERE c.NAME = 'Sci-Fi' 
GROUP BY Customer_name
HAVING COUNT(r.INVENTORY_ID)>2
ORDER BY Customer_name;


-- Write a query to find the full names of those customers who have rented at least one movie and belong to the city Arlington.
SELECT FIRST_NAME || ' ' || LAST_NAME AS Customer_name
FROM CUSTOMER cus INNER JOIN ADDRESS ad using(ADDRESS_ID)
INNER JOIN CITY ct using(CITY_ID)
INNER JOIN RENTAL r using(CUSTOMER_ID)
WHERE ct.CITY = 'Arlington' 
GROUP BY Customer_name
HAVING COUNT(r.INVENTORY_ID)>=1;



-- Write a query to find the number of movies rented across each country. 
-- Display only those countries where at least one movie was rented. 
-- Arrange these countries in the alphabetical order.

SELECT COUNTRY AS Country, count(RENTAL_ID) AS Rental_count
FROM COUNTRY INNER JOIN CITY using(COUNTRY_ID)
INNER JOIN ADDRESS using(CITY_ID)
INNER JOIN CUSTOMER using(ADDRESS_ID)
INNER JOIN RENTAL using(CUSTOMER_ID)
GROUP BY Country
HAVING count(RENTAL_ID)>=1
ORDER BY Country;


-- 1. List all customers who live in Texas (use 
-- JOINs) 

SELECT * FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
WHERE address.district = 'Texas';
-- 2. Get all payments above $6.99 with the Customer's Full Name 

SELECT customer.first_name, customer.last_name, amount FROM payment
INNER JOIN customer 
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;

-- 3. Show all customers names who have made payments over $175(use subqueries) 

SELECT * FROM customer
WHERE 
customer_id IN (
	SELECT customer_id FROM payment 
	WHERE amount > 175
);



-- 4. List all customers that live in Nepal (use the city 
-- table) 
SELECT * FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country.country = 'Nepal';


-- 5. Which staff member had the most 
-- transactions? 

SELECT * FROM staff
WHERE staff_id IN (
	SELECT staff_id FROM payment
	GROUP BY staff_id
	ORDER BY COUNT(staff_id) DESC
	LIMIT 1
);


-- 6. How many movies of each rating are 
-- there? 

SELECT rating, COUNT(rating) FROM film
GROUP BY rating
ORDER BY COUNT(rating);

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)

SELECT * FROM customer
WHERE customer_id IN (
	SELECT customer_id FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) < 2
);

-- 8. How many free rentals did our stores give away?

SELECT COUNT(amount) AS free_rentals FROM payment
WHERE amount < 0.01
-- 1. List all customers who live in Texas (use
-- JOINs)
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';

-- "Jennifer""Davis""Texas"
--"Kim""Cruz""Texas"
-- "Richard""Mccrary""Texas"
-- "Bryan""Hardison""Texas"
-- "Ian""Still""Texas"
-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT first_name, last_name, amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, amount
HAVING amount > 6.99
ORDER BY customer.customer_id;
--There are a lot for this answer.

-- 3. Show all customers names who have made at least 4 payments(use
-- subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY payment.customer_id
	HAVING COUNT(amount) > 4
);

SELECT first_name, last_name, COUNT(customer_id) 
FROM customer
GROUP BY customer.first_name, customer.last_name
WHERE customer_id (
	SELECT customer_id
	FROM payment
	HAVING COUNT(customer_id) > 4
)

-- 4. List all customers that live in Nepal (use the city
-- table)
SELECT first_name, last_name, country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

--Kevin Schuler lives in Nepal

-- 5. Which staff member (first/last name) had the most
-- transactions?
SELECT first_name, last_name, COUNT(amount)
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name
WHERE amount IN(
	SELECT amount
	FROM payment
	GROUP BY payment.amount
	HAVING COUNT(amount) > 4
	ORDER BY customer.customer_id
);;

--Jon Stephens has the most with 7304

-- 6. Which movie title(s) has been rented the most?
SELECT title, COUNT(rental_id)
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC
;

-- Bucket Brotherhood at 34 rentals

-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)

SELECT first_name, last_name
FROM customer
WHERE customer_id  IN(
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
)

-- 45 People have made a single payment above 6.99

-- 8. Which employee gave out the most free rentals
SELECT first_name, last_name, COUNT(amount), amount
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name, payment.amount
ORDER BY amount ASC

-- Mike Hillyer gave the most free rentals at 15 total

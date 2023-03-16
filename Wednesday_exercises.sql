--1. List all customers who live in Texas (use JOINs)

SELECT c.first_name , c.last_name , a.district  
FROM customer c
JOIN address a 
ON c.address_id = a.address_id 
WHERE district = 'Texas';


--2. List all payments of more than $7.00 with the customer's first and last name

SELECT c.first_name, c.last_name, p.amount 
FROM customer c
JOIN payment p 
ON c.customer_id = p.customer_id 
WHERE amount > 7;

--3. Show all customer names who have made over $175 in payments (use
--subqueries)

SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
	SELECT customer_id
	FROM payment 
	GROUP BY customer_id 
	HAVING sum(amount) > 175
);


--4. List all customers that live in Argentina (use the city table)

SELECT *
FROM country;

SELECT city_id
FROM city 
WHERE country_id = 6;

SELECT first_name, last_name, city_id
FROM customer c
JOIN address a
ON c.address_id = a.address_id 
WHERE city_id IN (
	SELECT city_id
	FROM city 
	WHERE country_id = 6
);

--5. Show all the film categories with their count in descending order

SELECT name, count(*)
FROM category 
GROUP BY name
ORDER BY name DESC;

--6. What film had the most actors in it (show film info)?

SELECT  f.film_id, count(*)
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id 
JOIN actor a 
ON a.actor_id = fa.actor_id 
GROUP BY f.film_id
ORDER BY count(*) DESC
LIMIT 1;

--7. Which actor has been in the least movies?

SELECT concat(first_name,' ',last_name) AS full_name,count(*)
FROM film f
JOIN film_actor fa
ON f.film_id = fa.film_id 
JOIN actor a 
ON a.actor_id = fa.actor_id 
GROUP BY full_name
ORDER BY count(*) ASC
LIMIT 1;

--8. Which country has the most cities?

SELECT country.country_id, count(*), country.country
FROM city
JOIN country 
ON city.country_id = country.country_id 
GROUP BY country.country_id
ORDER BY count(*) DESC
LIMIT 1

--9. List the actors who have been in between 20 and 25 films.

SELECT a.actor_id, count(*),  a.first_name, a.last_name 
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id 
JOIN film f 
ON f.film_id = fa.film_id 
GROUP BY a.actor_id, a.first_name , a.last_name 
HAVING count(*) BETWEEN 20 AND 25
ORDER BY count(*)
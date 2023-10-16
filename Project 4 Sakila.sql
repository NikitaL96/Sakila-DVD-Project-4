----- Project 4: Sakila Database ---------

use sakila;
select * from rental;
select * from store;
select * from customer;
select * from inventory;

-- Q-1: How many DVDs are currently available for rent/sale?

SELECT COUNT(DISTINCT inventory_id) AS rented_dvds
FROM rental
WHERE return_date IS NULL;

-- Q-2: Which DVDs are currently checked out by customers?

SELECT i.inventory_id, f.title, r.customer_id, r.rental_date
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE r.return_date IS NULL
LIMIT 10;

-- Q-3: Who are the top 10 customers by rental frequency?

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY rental_count DESC
LIMIT 10; 


-- Q-4: What are the most popular movie genres among customers?

SELECT c.name AS category_name, COUNT(*) AS film_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY film_count DESC;

-- Q-5: How is the revenue distributed by film rating?

SELECT f.rating, SUM(p.amount) AS revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.rating
ORDER BY revenue DESC;

-- Q-6: Which actors have appeared in the most films?

SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS film_appearances
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_appearances DESC 
limit 10;

-- Q-7: What is the total revenue earned for each month in the year 2005?

SELECT YEAR(r.rental_date) AS rental_year, MONTH(r.rental_date) AS rental_month, SUM(p.amount) AS total_revenue
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
WHERE YEAR(r.rental_date) = 2005
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;

-- Q-8: How does DVD rental activity vary over time?

SELECT YEAR(rental_date) AS rental_year, MONTH(rental_date) AS rental_month, COUNT(*) AS rental_count
FROM rental
GROUP BY rental_year, rental_month
ORDER BY rental_year, rental_month;

-------------------- End ---------------
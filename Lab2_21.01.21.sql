
show databases;
use sakila;


-- 1 Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.

select * from film limit 2;

select title, length, dense_rank() over (order by length ASC) as Ranking from film
where length is NOT NULL;

-- 2 Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank.

select title, length, rating, dense_rank () over (partition by rating order by length ASC) as ranking from film
where length is NOT NULL and length > 0;


-- 3 How many films are there for each of the categories in the category table. Use appropriate join to write this query
select * from film limit 2; -- film_id F
select * from film_category limit 3; -- category_id, film_id FC
select * from category limit 2 -- category_id name C

select c.category_id as category, c.name as cat_name, count(f.film_id) as total from film as f
left join film_category as fc
on fc.film_id = f.film_id
left join category as c
on fc.category_id = c.category_id
group by cat_name
order by category ASC;


-- Which actor has appeared in the most films?

select a.actor_id, a.first_name, a.last_name, count(f.film_id) as movies_total from actor as a 
join film_actor as f
on a.actor_id = f.actor_id
group by a.actor_id
order by movies_total desc
limit 1;

-- Most active customer (the customer that has rented the most number of films)

select c.first_name, c.last_name, COUNT(r.rental_id) as movies_rented from rental as r
join customer as c
on r.customer_id = c.customer_id 
group by r.customer_id
order by movies_rented DESC limit 1;

--BONUS -- 

select f.title, count(r.rental_id) as rentals from film as f
join inventory as i
on f.film_id=i.film_id 
join rental as r 
on i.inventory_id = r.inventory_id
group by f.film_id
order by rentals desc
limit 1;


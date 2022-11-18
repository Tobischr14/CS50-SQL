-- In 1.sql, write a SQL query to list the titles of all movies released in 2008.
    -- Your query should output a table with a single column for the title of each movie.

select title from movies
where year = 2008;





-- -- test
-- select title, rating, votes from movies
-- join ratings
-- on id = movie_id
-- where votes >= 100
-- order by rating desc
-- limit 50;

-- -- test
-- select title, year, rating from movies
-- join ratings
-- on id = movie_id
-- where title like "%Lord of the Rings%" and votes >= 100
-- order by year, rating;

-- -- test
-- select title, year from movies
-- order by year desc, title
-- limit 100;

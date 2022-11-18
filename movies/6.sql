-- In 6.sql, write a SQL query to determine the average rating of all movies released in 2012.
    -- Your query should output a table with a single column and a single row (not counting the header) containing the average rating.

-- select rating from ratings
-- where references movies(id) == (select id from movies where year = 2012);

select avg(rating) from ratings
-- inner join movies
-- on movie_id = id
where movie_id in
(
    select id from movies
    where year == 2012
);
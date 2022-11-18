-- In 7.sql, write a SQL query to list all movies released in 2010 and their ratings, in descending order by rating. For movies with the same rating, order them alphabetically by title.
    -- Your query should output a table with two columns, one for the title of each movie and one for the rating of each movie.
    -- Movies that do not have ratings should not be included in the result.

select title, rating from ratings
inner join movies
on movie_id = id

where movie_id in (select id from movies where year = 2010)
order by rating desc, title;

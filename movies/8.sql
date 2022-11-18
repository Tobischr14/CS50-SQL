-- In 8.sql, write a SQL query to list the names of all people who starred in Toy Story.
    -- Your query should output a table with a single column for the name of each person.
    -- You may assume that there is only one movie in the database with the title Toy Story.

select name from people
-- join stars
-- on id = person_id
where id IN
    (select person_id from stars
    -- inner join movies
    -- on movie_id = id
    where movie_id in
        (select id from movies
        where title == "Toy Story")
    );
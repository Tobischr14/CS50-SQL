-- In 12.sql, write a SQL query to list the titles of all movies in which both Johnny Depp and Helena Bonham Carter starred.
    -- Your query should output a table with a single column for the title of each movie.
    -- You may assume that there is only one person in the database with the name Johnny Depp.
    -- You may assume that there is only one person in the database with the name Helena Bonham Carter.

select title from movies
where id in
(
    -- select movie_id from stars
    select movie_id from stars
    where movie_id in
    (
        select movie_id from stars
        -- join people
        -- on person_id = id
        where person_id in
        (
            select id from people
            where name = "Johnny Depp"
        )
    )
    and person_id in
    (
        select id from people
        where name = "Helena Bonham Carter"
    )
)
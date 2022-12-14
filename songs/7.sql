-- In 7.sql, write a SQL query that returns the average energy of songs that are by Drake.
    -- Your query should output a table with a single column and a single row containing the average energy.
    -- You should not make any assumptions about what Drake’s artist_id is.

select AVG(energy) from songs
where artist_id == (select id from artists where name == "Drake");
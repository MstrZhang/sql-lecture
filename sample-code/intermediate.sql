-- GROUP BY: (tracks)
----------------------------------------------------------

-- count the number of tracks per album
-- we group the tracks by album to apply the COUNT() function
SELECT
    albumid,
    COUNT(trackid)
FROM
    tracks
GROUP BY
    albumid;

-- we can also use ORDER BY in conjunction
SELECT
    albumid,
    COUNT(trackid)
FROM
    tracks
GROUP BY
    albumid
ORDER BY COUNT(trackid) DESC;

-- we can also include a JOIN to get the album's title
SELECT
    tracks.albumid,
    title,
    COUNT(trackid)
FROM
    tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY
    tracks.albumid;

-- HAVING: (tracks)
----------------------------------------------------------

-- count the number of tracks with albumid = 1
SELECT
    albumid,
    COUNT(trackid)
FROM
    tracks
GROUP BY
    albumid
HAVING albumid = 1;

-- we can also use conditionals similarly to the WHERE clause
-- for example using BETWEEN
SELECT
    albumid,
    COUNT(trackid)
FROM
    tracks
GROUP BY
    albumid
HAVING COUNT(albumid) BETWEEN 18 AND 20
ORDER BY albumid;

-- like above, we can also add a JOIN
-- we find all albums that have a total length greater than 60m milliseconds
SELECT
    tracks.albumid,
    title,
    SUM(milliseconds) AS length
FROM
    tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
GROUP BY
    tracks.albumid
HAVING
    length > 60000000;

-- CASE: (customers)
----------------------------------------------------------

-- suppose you're making a report of customer groups
-- if a customer is located in 'Canada', they belong to 'Domestic'
-- if a customer is located outside of 'Canada', they are 'Foreign'
SELECT
    customerid,
    firstname,
    lastname,
    CASE country
        WHEN 'Canada'
            THEN 'Domestic'
        ELSE 'Foreign'
    END CustomerGroup
FROM customers
ORDER BY
    lastname,
    firstname;

-- Subqueries:
----------------------------------------------------------

-- get the customers whose sales representatives are in Canada
SELECT customerid,
       firstname,
       lastname
FROM customers
WHERE supportrepid IN (
    SELECT employeeid
    FROM employees
    WHERE country = 'Canada');

-- using an aggregate function
-- remember than you can't pass in a value to an aggregate function
-- calculate average size of all albums

-- BAD QUERY:
-- this will not work (you have sum() inside avg())
SELECT AVG(SUM(bytes))
FROM tracks
GROUP BY albumid;

-- GOOD QUERY:
-- this will work
SELECT AVG(album.size)
FROM (
    SELECT SUM(bytes) size
    FROM tracks
    GROUP BY albumid
) AS album;

-- correlated subquery
-- subquery depends on the result from the outer query
-- cannot be run independently
-- return albums whose size is less than 10 MB
SELECT
    albumid,
    title
FROM albums
WHERE 10000000 > (
    SELECT SUM(bytes)
    FROM tracks
    WHERE tracks.albumid = albums.albumid
) ORDER BY title;

-- subquery in the SELECT clause
SELECT
    albumid,
    title,
    (
        SELECT COUNT(trackid)
        FROM tracks
        WHERE tracks.albumid = albums.albumid
    )
    tracks_count
FROM albums
ORDER BY tracks_count DESC;
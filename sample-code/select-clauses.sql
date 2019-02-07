-- SELECT: (tracks relation)
----------------------------------------------------------

-- get everything from tracks
SELECT * FROM tracks;

-- suppose we only want a couple of columns...
SELECT
    trackid, name, composer, unitprice
FROM
    tracks;


-- ORDER BY: (tracks relation)
----------------------------------------------------------

-- order by the longest tracks first
SELECT
    name, milliseconds, albumid
FROM
    tracks
ORDER BY
    milliseconds DESC;

-- you can also order by multiple columns at once
-- (orders by albumid first then milliseconds second)
SELECT
    name, milliseconds, albumid
FROM
    tracks
ORDER BY
    albumid ASC,
    milliseconds DESC;

-- DISTINCT: (customers relation)
----------------------------------------------------------

-- get the cities that the customers are from
-- some customers can come from the same city, duplicates are pointless
SELECT
    city
FROM
    customers
ORDER BY
    city;

-- we can use DISTINCT on multiple columns
-- (e.g. using it on city and country)
SELECT DISTINCT
    city,
    country
FROM
    customers
ORDER BY
    country;

-- WHERE: (tracks relation)
----------------------------------------------------------

-- the equality operator
SELECT 
    *
FROM
    tracks
WHERE
    albumid = 1;

-- combining operators
SELECT
    *
FROM
    tracks
WHERE
    albumid = 1
    AND milliseconds > 250000;

-- LIKE
-- we use this to pattern match strings
-- the '%' means where we stop searching for the pattern

-- % in front means "starts with"
-- (stop searching at the end of the string)
-- % in back means "ends with"
-- (stop searching at the beginning of the string)
-- % on both sides means anywhere inside string
SELECT
    name,
    albumid,
    composer
FROM tracks
WHERE
    composer LIKE '%marvin gaye%'
ORDER BY
    albumid;

-- we can use an underscore _ to search for a single character
SELECT
    trackid,
    name
FROM tracks
WHERE
    name LIKE '%Br_wn%';

-- IN
-- check if the value is in a list of values
-- IN has a different use that we will see later
SELECT
    name,
    albumid,
    mediatypeid
FROM tracks
WHERE
    mediatypeid IN (2, 3);

-- we can do the same thing using OR
SELECT
    name,
    albumid,
    mediatypeid
FROM tracks
WHERE
    mediatypeid = 2 OR mediatypeid = 3;

-- we can also throw in a NOT to get the opposite set
SELECT
    name,
    albumid,
    mediatypeid
FROM tracks
WHERE
    mediatypeid NOT IN (2, 3);


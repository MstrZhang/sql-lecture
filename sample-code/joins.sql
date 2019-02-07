-- INNER JOIN: (tracks, albums, artists)
----------------------------------------------------------

-- get data about tracks the albums they're from
-- SQLite uses the attribute "albumid" in "tracks" to search for matches with "trackid" in "tracks"
-- if it finds a match, it combines the data of rows in both tables as the result
SELECT
    trackid,
    name,
    title
FROM
    tracks
INNER JOIN albums ON albums.albumid = tracks.trackid

-- to visualize this better
-- (visualization query)
SELECT
    trackid,
    name,
    tracks.albumid AS album_id_tracks,
    albums.albumid AS album_id_albums,
    title
FROM
    tracks
    INNER JOIN albums ON albums.albumid = tracks.albumid;

-- not only limited to two tables
-- (here we use AS to rename the columns in the result to make it easier to read)
SELECT
    trackid,
    tracks.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM
    tracks
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;

-- you can also add a WHERE clause to a join
SELECT
    trackid,
    tracks.name AS Track,
    albums.title AS Album,
    artists.name AS Artist
FROM
    tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid
WHERE
    artists.artistid = 10;

-- LEFT JOIN: (albums, artists)
----------------------------------------------------------

-- find the artists who do not have any albums
-- (an artist that has no albums will have a NULL albumid column)
SELECT
    artists.artistid
    albumid
FROM
    artists
LEFT JOIN albums ON albums.artistid = artists.artistid
WHERE
    albumid IS NULL;

-- CROSS JOIN:
----------------------------------------------------------

-- the cross join is generally a useless operation
-- it is sometimes useful though for "generating tables"
-- we'll use cross join to create a complete list of cards

CREATE TABLE ranks (
    rank TEXT NOT NULL
);

CREATE TABLE suits (
    suit TEXT NOT NULL
);

INSERT INTO ranks(rank) 
VALUES('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('10'),('J'),('Q'),('K'),('A');
 
INSERT INTO suits(suit) 
VALUES('Clubs'),('Diamonds'),('Hearts'),('Spades');

-- using the ranks and suits, we can create a complete deck of cards
-- this is because the CROSS JOIN creates every possible matching of columns
SELECT rank, suit
FROM ranks
CROSS JOIN suits
ORDER BY suit;

-- SELF JOIN: (employees)
----------------------------------------------------------

-- find out who reports to who
-- the || operator is a concatenation (combines the strings together)
SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
FROM employees e
INNER JOIN employees m ON m.employeeid = e.reportsto
ORDER BY manager;

/* 1.  Write a query to display all the records in the table tutorial.oscar_nominees */
SELECT *
FROM tutorial.oscar_nominees;

/* 2. Write a query to find the distinct values in the ‘year’ column */
 SELECT DISTINCT year 
 FROM tutorial.oscar_nominees
 ORDER BY year;

/* 3. Write a query to filter the records from year 1999 to year 2006 */
SELECT * 
FROM tutorial.oscar_nominees
WHERE year BETWEEN 1999 AND 2006;

/* 4. Write a query to filter the records for either year 1991 or 1998. */
SELECT * 
FROM tutorial.oscar_nominees
WHERE year IN (1991, 1998);

/* 5. Write a query to return the winner movie name for the year of 1997. */
SELECT movie, nominee 
FROM tutorial.oscar_nominees
WHERE year = 1997 AND winner = true; 

/* 6. Write a query to return the winner in the ‘actor in a leading role’ and ‘actress in a leading role’ category for the year of 1994,1980, and 2008. */
SELECT nominee, category, year 
FROM tutorial.oscar_nominees 
WHERE category IN ('actor in a leading role', 'actress in a leading role') AND 
year IN (1994, 1980, 2008) AND winner = true
ORDER BY year;

/* 7. Write a query to return the name of the movie starting from letter ‘a’ */
SELECT movie 
FROM tutorial.oscar_nominees
WHERE movie LIKE 'A%'

/* 8. Write a query to return the name of movies containing the word ‘the’.*/
SELECT movie 
FROM tutorial.oscar_nominees
WHERE movie LIKE '%the%';

/* 9. Write a query to return all the records where the nominee name starts with “c” and ends with “r”. */
SELECT *
FROM tutorial.oscar_nominees
WHERE movie LIKE 'C%' AND movie LIKE '%r'; 

/* 10. Write a query to return all the records where the movie was released in 2005 and movie name does
not start with ‘a’ and ‘c’ and nominee was a winner */
SELECT * 
FROM tutorial.oscar_nominees
WHERE year = 2005 AND movie NOT LIKE 'A%'
AND movie NOT LIKE '%C' AND winner = true


/* View all enteries */
SELECT *
FROM tutorial.crunchbase_companies ; 

/* 1.Find the top 5 countries(country code) with the highest number of operating companies. Ensure
the country code is not null. */
	
SELECT country_code, COUNT(name) num_companies 
FROM tutorial.crunchbase_companies 
WHERE status = 'operating' AND country_code IS NOT NULL
GROUP BY country_code
ORDER BY num_companies DESC
LIMIT 5 ; 


/* 2. How many companies have no country code available in the dataset */

SELECT COUNT(name)
FROM tutorial.crunchbase_companies 
WHERE country_code IS NULL ;


/* 3. Find the number of companies starting with letter ‘g’ founded in France(FRA) and still operational(status = operating) */

SELECT COUNT(name)
FROM tutorial.crunchbase_companies 
WHERE name LIKE 'G%' AND country_code = 'FRA'
AND status = 'operating' ; 
 
/* 4. How many advertising, founded after 2003, are acquired */

SELECT COUNT(name)
FROM tutorial.crunchbase_companies 
WHERE status = 'acquired' AND founded_year > 2003
AND category_code = 'advertising' ; 

/* 5. Calculate the average funding_total_usd per company for the companies founded in the
software, education, and analytics category. */

SELECT category_code, AVG(funding_total_usd)
FROM tutorial.crunchbase_companies 
WHERE category_code IN ('software', 'education', 'analytics')
GROUP BY category_code ;

/* 6. Find the city having more than 50 closed companies. Return the city and number of companies closed. */

SELECT city, COUNT(name) num_companies 
FROM tutorial.crunchbase_companies 
WHERE status = 'closed' AND city IS NOT NULL
GROUP BY city
HAVING COUNT(name) >= 50 ;


/* 7. Find the number of bio-tech companies who are founded after 2000 and either have more than
1Mn funding or have ipo and secured more than 1 round of funding. */

SELECT COUNT(name)
FROM tutorial.crunchbase_companies  
WHERE category_code = 'biotech' AND founded_year > 2000
AND (funding_total_usd > 1000000 OR status = 'ipo') AND funding_rounds > 1 ;

/* 8. Find all number of all acquired companies founded between 1980 and 2005 and founded in the
city ending with the word ‘city’. Return the city name and number of acquired companies. */

SELECT city, COUNT(name) num_acquired_co
FROM tutorial.crunchbase_companies 
WHERE founded_year BETWEEN 1980 AND 2005
AND city LIKE '%City'
AND status = 'acquired' 
GROUP BY city;

/* 9. Find the number of ‘hardware’ companies founded outside ‘USA’ and did not take any funding.
Return the country code and number of hardware companies in descending order */

SELECT country_code, COUNT(name) num_co
FROM tutorial.crunchbase_companies 
WHERE category_code = 'hardware' AND
country_code <> 'USA' AND
funding_total_usd IS NULL 
GROUP BY country_code
ORDER BY num_co DESC ;

/* 10. Find the 5 most popular company category(category with highest companies) across the city
Singapore, Shanghai, and Bangalore. Return category code and number of companies */

SELECT category_code, COUNT(name) count_co
FROM tutorial.crunchbase_companies 
WHERE city IN ('Singapore', 'Shanghai', 'Bangalore')
GROUP BY category_code
ORDER BY count_co DESC 
LIMIT 5 ;
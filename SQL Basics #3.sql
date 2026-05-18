-- Returns first 100 rows from tutorial.kag_conversion_data
  SELECT * FROM tutorial.kag_conversion_data LIMIT 100;

/* 2. Write a query to count the total number of records in the tutorial.kag_conversion_data dataset. */
SELECT COUNT(*)
FROM tutorial.kag_conversion_data;

/* 3. Write a query to count the distinct number of fb_campaign_id. */
SELECT COUNT(DISTINCT fb_campaign_id)
FROM tutorial.kag_conversion_data;

/* 4. Write a query to find the maximum spent, average interest, minimum impressions for ad_id. */
SELECT MAX(spent), AVG(interest), MIN(impressions)
FROM tutorial.kag_conversion_data;

/* 5. Write a query to create an additional column spent per impressions(spent/impressions) */
SELECT *, (spent/impressions) spent_per_impressions 
FROM tutorial.kag_conversion_data;

/* 6. Write a query to count the ad_campaign for each age group. */
SELECT age, COUNT(ad_id) ad_campaign
FROM tutorial.kag_conversion_data
GROUP BY age;

/* 7. Write a query to calculate the average spent on ads for each gender category. */
SELECT gender, AVG(spent) average_spent
FROM tutorial.kag_conversion_data
GROUP BY gender;

/* 8. Write a query to find the total approved conversion per xyz campaign id. Arrange the total
conversion in descending order. */
SELECT xyz_campaign_id, SUM (approved_conversion) total_spent 
FROM tutorial.kag_conversion_data
GROUP BY xyz_campaign_id
ORDER BY total_spent DESC; 

/* 9. Write a query to show the fb_campaign_id and total interest per fb_campaign_id. Only show the
campaign which has more than 300 interests. */
SELECT fb_campaign_id, SUM(interest) total_interest 
FROM tutorial.kag_conversion_data
GROUP BY fb_campaign_id
HAVING SUM(interest) >= 300 
ORDER BY total_interest DESC; 

/* 10. Write a query to find the age and gender segment with maximum impression to interest ratio. Return
three columns - age, gender, impression_to_interest */
SELECT age, gender, (SUM(impressions)/SUM(interest)) impression_to_interest 
FROM tutorial.kag_conversion_data
GROUP BY age, gender 
ORDER BY impression_to_interest DESC 
LIMIT 1;

/* 11. Write a query to find the top 2 xyz_campaign_id and gender segment with the maximum
total_unapproved_conversion (total_conversion - approved_conversion) */ 
SELECT xyz_campaign_id, gender, (SUM(total_conversion) - SUM(approved_Conversion)) total_unapproved_Conversion
FROM tutorial.kag_conversion_data
GROUP BY xyz_campaign_id, gender
ORDER BY total_unapproved_conversion DESC 
LIMIT 2; 

SELECT *
FROM tutorial.sat_scores; 

/* 1. Write a query to add column - avg_sat_writing. Each row in this column should include average
marks in the writing section of the student per school. */
SELECT *, 
AVG(sat_writing) OVER (PARTITION BY school) avg_sat_writing
FROM tutorial.sat_scores;

/* 2. In the above question, add an additional column - count_per_school. Each row of this column should
include number of students per school */
SELECT *, 
AVG(sat_writing) OVER (PARTITION BY school) avg_sat_writing, 
COUNT(student_id) OVER (PARTITION BY school) count_per_school
FROM tutorial.sat_scores;

/* 3. In the above question, add two additional columns - max_per_teacher and min_per_teacher. Each
row of this column should include maximum and minimum marks in maths per teacher respectively. */
SELECT *, 
AVG(sat_writing) OVER (PARTITION BY school) avg_sat_writing, 
COUNT(student_id) OVER (PARTITION BY school) count_per_school, 
MAX(sat_math) OVER (PARTITION BY teacher) max_per_teacher, 
MIN(sat_math) OVER (PARTITION BY teacher) min_per_teacher
FROM tutorial.sat_scores;

/* 4. For the dataset, write a query to add the two columns cum_hrs_studied and total_hrs_studied. Each
row in cum_hrs_studied should display the cumulative sum of hours studied per school. Each row in
the total_hrs_studied will display total hours studied per school. Order the data in the ascending
order of student id */
SELECT *, 
SUM(hrs_studied) OVER (PARTITION BY school ORDER BY student_id) cum_hrs_studied, 
SUM(hrs_studied) OVER (PARTITION BY school) total_hrs_studied 
FROM tutorial.sat_scores; 

/* 5. For the dataset, write a query to add column sub_hrs_studied and total_hrs_studied. Each row in
sub_hrs_studied should display the sum of hrs_studied for a row above, a row below, and current
row per school. Order the data in the ascending order of student id */
SELECT *, 
SUM(hrs_studied) OVER (PARTITION BY school ORDER BY student_id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) sub_hrs_studied, 
SUM(hrs_studied) OVER (PARTITION BY school) total_hrs_studied
FROM tutorial.sat_scores; 

/* 6. Write a query to rank the students per school on the basis of scores in verbal. Use both rank and
dense_rank function. Students with the highest marks should get rank 1. */
SELECT *, 
RANK() OVER (PARTITION BY school ORDER BY sat_verbal DESC), 
DENSE_RANK() OVER (PARTITION BY school ORDER BY sat_verbal DESC)
FROM tutorial.sat_scores; 

/* 7. Write a query to rank the students per school on the basis of scores in writing. Use both rank and
dense_rank function. Student with the highest marks should get rank 1. */
SELECT *, 
RANK() OVER(PARTITION BY school ORDER BY sat_writing DESC), 
DENSE_RANK() OVER(PARTITION BY school ORDER BY sat_writing DESC)
FROM tutorial.sat_Scores; 

/* 8. Write a query to find the top 5 students per teacher who spent maximum hours studying. */
SELECT teacher, student_id, hrs_studied
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY school ORDER BY hrs_studied DESC) rank_hrs_studied
      FROM tutorial.sat_scores) 
WHERE rank_hrs_studied <= 5; 

/* 9. Write a query to find the worst 5 students per school who got minimum marks in sat_math */
SELECT school, student_id, sat_math 
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY school ORDER BY sat_math)
      FROM tutorial.sat_scores) s
WHERE row_number < 6

/* 10. Write a query to divide the dataset into quartile on the basis of marks in sat_verbal. */
SELECT*, 
NTILE(4) OVER(ORDER BY sat_verbal)
FROM tutorial.sat_scores ;

/* 11. For ‘Petersville HS’ school, write a query to arrange the students in the ascending order of hours
studied. Also, add a column to find the difference in hours studied from the student above(in the
row). Exclude the cases where hrs_studied is null. */
SELECT student_id, hrs_studied, hrs_studied - LAG(hrs_studied, 1) OVER(ORDER BY school) difference_to_preceeding_st 
FROM tutorial.sat_scores
WHERE school = 'Petersville HS' AND hrs_studied IS NOT NULL;

/* 12. For ‘Washington HS’ school, write a query to arrange the students in the descending order of
sat_math. Also, add a column to find the difference in sat_math from the student below(in the row) */
SELECT student_id, sat_math, sat_math - LEAD(sat_math, 1) OVER (ORDER BY sat_math DESC) score_diff
FROM tutorial.sat_scores
WHERE school = 'Washington HS';

/* 13. Write a query to return 4 columns - student_id, school, sat_writing, difference in sat_writing and
average marks scored in sat_writing in the school. */
SELECT student_id, school, sat_writing, 
sat_writing - AVG(sat_writing) OVER (PARTITION BY school) diff_to_avg
FROM tutorial.sat_scores;

/* 14. Write a query to return 4 columns - student_id, teacher, sat_verbal, difference in sat_verbal and
minimum marks scored in sat_verbal per teacher. */
SELECT student_id, teacher, sat_verbal, sat_verbal - MIN(sat_verbal) OVER (PARTITION BY teacher ORDER BY sat_verbal) score_diff
FROM tutorial.sat_scores; 

/* 15. Write a query to return the student_id and school who are in bottom 20 in each of sat_verbal,
sat_writing, and sat_math for their school. */
WITH cte AS( 
  SELECT *, 
  ROW_NUMBER() OVER(ORDER BY sat_verbal) rank_verbal, 
  ROW_NUMBER() OVER(ORDER BY sat_writing) rank_writing, 
  ROW_NUMBER() OVER(ORDER BY sat_math) rank_math 
  FROM tutorial.sat_scores
)

SELECT student_id, school, rank_verbal, rank_writing, rank_math 
FROM cte 
WHERE rank_verbal < 21 OR rank_writing < 21 OR rank_math < 21; 

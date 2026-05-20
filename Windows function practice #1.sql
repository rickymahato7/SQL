SELECT *
FROM tutorial.sat_scores;

/* Write a query to add column - avg_sat_writing. Each row in this column should include average
marks in the writing section of the student per school.*/
SELECT *, 
AVG(sat_writing) OVER (PARTITION BY school) avg_sat_writing  
FROM tutorial.sat_scores;

/*In the above question, add an additional column - count_per_school. Each row of this column should
include number of students per school*/
SELECT *, 
AVG(sat_writing) OVER (PARTITION BY school) avg_sat_writing, 
COUNT(student_id) OVER (PARTITION BY school) count_per_school
FROM tutorial.sat_scores;

/*In the above question, add two additional columns - max_per_teacher and min_per_teacher. Each
row of this column should include maximum and minimum marks in maths per teacher respectively.*/
SELECT *, 
AVG(sat_writing) OVER (PARTITION BY school) avg_sat_writing, 
COUNT(student_id) OVER (PARTITION BY school) count_per_school, 
MIN(sat_math) OVER (PARTITION BY teacher) min_math_score,  
MAX(sat_math) OVER (PARTITION BY teacher) max_math_score
FROM tutorial.sat_scores;

/*For the dataset, write a query to add the two columns cum_hrs_studied and total_hrs_studied. Each
row in cum_hrs_studied should display the cumulative sum of hours studied per school. Each row in
the total_hrs_studied will display total hours studied per school. Order the data in the ascending
order of student id*/
SELECT *, 
SUM(hrs_studied) OVER (PARTITION BY school ORDER BY student_id) cumulative_hours,  
SUM(hrs_studied) OVER (PARTITION BY school) total_hours 
FROM tutorial.sat_scores;

/*For the dataset, write a query to add column sub_hrs_studied and total_hrs_studied. Each row in
sub_hrs_studied should display the sum of hrs_studied for a row above, a row below, and current
row per school. Order the data in the ascending order of student id*/
SELECT *, 
SUM(hrs_studied) OVER (PARTITION BY school ORDER BY student_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) sub_hrs_studied,  
SUM(hrs_studied) OVER (PARTITION BY school) total_hrs_studied
FROM tutorial.sat_scores;

/*Write a query to rank the students per school on the basis of scores in verbal. Use both rank and
dense_rank function. Students with the highest marks should get rank 1.*/
SELECT *, 
RANK() OVER (PARTITION BY school ORDER BY sat_verbal DESC), 
DENSE_RANK() OVER (PARTITION BY school ORDER BY sat_verbal DESC) 
FROM tutorial.sat_scores; 

/*Write a query to rank the students per school on the basis of scores in writing. Use both rank and
dense_rank function. Student with the highest marks should get rank 1.*/
SELECT *, 
RANK() OVER (PARTITION BY school ORDER BY sat_writing DESC), 
DENSE_RANK() OVER (PARTITION BY school ORDER BY sat_writing DESC) 
FROM tutorial.sat_Scores;

/*Write a query to find the top 5 students per teacher who spent maximum hours studying.*/
SELECT teacher, student_id 
FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY teacher ORDER BY hrs_studied DESC) rank_num
      FROM tutorial.sat_scores)
WHERE rank_num <= 5; 

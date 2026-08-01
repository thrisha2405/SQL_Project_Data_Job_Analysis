CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

/* CREATE TABLES FROM OTHER TABLES
CREATE THREE TABLES
- JAN 2023 JOBS
- FEB 2023 JOBS
- MAR 2023 JOBS
-- WILL BE USED TO SOLVE CASE ALSO CREATE TABLE TANLENAME AS
EXTRACT OUT ONLY SPECIFIC MINTHS */

SELECT job_posted_date
FROM march_jobs;

-- CASE studies
SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' Then 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

/* LABEL new column as follows
- 'Anywhere' jobs as 'Remote'
- 'New York,NY' jobs as 'Local'
- Otherwise 'Onsite'
*/

/*
Practice Problem Question
I want to categorize the salaries from each job posting.
 To see if it fits in my desired salary range.
 Put salary into different bucketsDefine what's a high,
  standard, or low salary with our own conditionsWhy? 
  It is easy to determine which job postings are worth 
  looking at based on salary.
   Bucketing is a common practice in data analysis
    when viewing categories.I only want to look at data analyst roles
    Order from highest to lowest
*/
SELECT
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg > 130000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 80000 AND 130000 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;
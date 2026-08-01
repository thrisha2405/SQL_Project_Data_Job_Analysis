/*Write a query to find the average 
salary both yearly (salary_year_avg) and
 hourly (salary_hour_avg) for job postings 
 that were posted after June 1, 2023. 
 Group the results by job schedule type.*/
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS salary_year_avg,
    AVG(salary_hour_avg) AS salary_hour_avg
FROM 
    job_postings_fact
WHERE 
    job_posted_date > '2023-06-01'
GROUP BY 
    job_schedule_type;

----------------------------------------------
/* Write a query to count the number of 
job postings for each month in 2023, 
adjusting the job_posted_date to be 
in 'America/New_York' time zone before 
extracting (hint) the month. 
Assume the job_posted_date is stored in UTC. 
Group by and order by the month.*/
SELECT 
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'America/New_York') AS month,
    COUNT(job_id) AS job_count
FROM 
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'America/New_York') = 2023
GROUP BY 
    month
ORDER BY 
    month;

--------------------------------------------------
/* Write a query to find companies (include company name)
 that have posted jobs offering health insurance,
  where these postings were made in the second quarter of 2023.
   Use date extraction to filter by quarter.*/
SELECT DISTINCT
    c.name AS company_name
FROM 
    job_postings_fact AS j
INNER JOIN 
    company_dim AS c ON j.company_id = c.company_id
WHERE 
    j.job_health_insurance = TRUE
    AND EXTRACT(QUARTER FROM j.job_posted_date) = 2
    AND EXTRACT(YEAR FROM j.job_posted_date) = 2023;

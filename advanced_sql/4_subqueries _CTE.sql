/* Subqueries:query nested inside a larger query
-- can be used in SELECT, FROM AND WHERE clauses
-- temporary table
*/
SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(month from job_posted_date) = 1    
) AS january_jobs;

/* COMMON TABLE EXPRESSION (CTEs):define a temporary result 
set that you can reference
-- Can refernece within a select,insert,update or delete
-- define with with
*/
WITH january_jobs AS (-- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT (MONTH FROM job_posted_date) = 1
) -- CTE definition emds here

SELECT *
FROM january_jobs;

--SUBQUERY
-- list of companies offering jobs that do not need a requiremtn of degree
SELECT 
    company_id,
    name AS company_name
FROM 
company_dim
WHERE company_id IN (
    SELECT 
            company_id
    FROM
            job_postings_fact
    WHERE 
            job_no_degree_mention = true
    ORDER BY
            company_id
)

SELECT name
FROM company_dim 
WHERE company_id IN (
    SELECT company_id  -- Only return ONE column here to match the outer WHERE
    FROM job_postings_fact 
    WHERE job_no_degree_mention = true
);

-- CTES
WITH company_job_count AS(
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC

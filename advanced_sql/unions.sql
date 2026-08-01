-- UNION
-- Combines results from two or more select statements
-- they need to have same amount of cols, and data type
-- gets rid of duplicate rowa unlike union all
-- all rows are unique
SELECT 
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

-- UNION ALL

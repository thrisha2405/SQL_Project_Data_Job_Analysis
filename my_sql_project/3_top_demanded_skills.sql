/*
Question:what are the most in-demand skills for data analyst?
-Join job postings to inner join table similar to query 2
- identify the top 4 in demand skills fro a data analyst
- focus on all job postings.
- Why? Retrieves the top 5 skills with the hihest demand in the job market ,
providing insights into the most valuable skills for job seekers
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/* 
Question: What are the most in-demand skills for Data Analysts?
Requirements:
- Join job postings to skills tables.
- Identify the top 5 in-demand skills for a Data Analyst.
- Focus on all job postings (market-wide).
Why? Retrieves the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers.


SELECT 
    skills_dim.skills AS skill_name, -- practice: Explicitly alias table.column
    COUNT(skills_job_dim.job_id) AS demand_count 
FROM 
    job_postings_fact 
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE 
    job_title_short = 'Data Analyst' -- Fixed: Removed the remote filter to include ALL jobs
GROUP BY 
    skills_dim.skills 
ORDER BY 
    demand_count DESC 
LIMIT 5; -- Matches the top 5 requested in your "Why" description
*/
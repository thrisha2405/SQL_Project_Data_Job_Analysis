/*
Question: What are the most optimal skills to learn?
- Optimal: High Demand AND High Paying
- Focus: Data Analyst roles with specified salaries and remote work
- Why? It targets skills that offer job security (high demand) 
  and financial incentive (high salary), providing a strategic roadmap.
*/

-- CTE 1: Calculate the demand count for each skill
WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_dim.skill_id
),

-- CTE 2: Calculate the average salary for each skill
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    -- Note: We don't strictly need skills_dim here because we just need skill_id to join
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = True
    GROUP BY
        skills_job_dim.skill_id
)

-- Main Query: Join both CTEs together to reveal the optimal insights
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN 
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.demand_count > 10 -- Optional threshold: Filters out rare fluke skills
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
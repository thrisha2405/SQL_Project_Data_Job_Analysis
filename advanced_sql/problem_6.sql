/* QuestionIdentify the top 5 skills that are 
most frequently mentioned in job postings. 
Use a subquery to find the skill IDs with the
 highest counts in the skills_job_dim table and 
 then join this result with the skills_dim 
 table to get the skill names.*/
 SELECT 
    skills_dim.skills AS skill_name,
    top_skills.skill_count
FROM (
    -- Subquery: Finds top 5 skill IDs first
    SELECT 
        skill_id,
        COUNT(job_id) AS skill_count
    FROM 
        skills_job_dim
    GROUP BY 
        skill_id
    ORDER BY 
        skill_count DESC
    LIMIT 5
) AS top_skills
INNER JOIN skills_dim ON top_skills.skill_id = skills_dim.skill_id;
/*QuestionDetermine the size category ('Small', 'Medium', or 'Large') 
for each company by first identifying the number of job postings 
they have. Use a subquery to calculate the total job postings per company.
 A company is considered 'Small' if it has less than 10 job postings,
  'Medium' if the number of job postings is between 10 and 50, 
  and 'Large' if it has more than 50 job postings. 
  Implement a subquery to aggregate job counts per company 
  before classifying them based on size.
*/
SELECT 
    company_dim.name AS company_name,
    company_job_counts.total_jobs,
    CASE 
        WHEN company_job_counts.total_jobs < 10 THEN 'Small'
        WHEN company_job_counts.total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM (
    -- Subquery: Counts total jobs per company first
    SELECT 
        company_id,
        COUNT(job_id) AS total_jobs
    FROM 
        job_postings_fact
    GROUP BY 
        company_id
) AS company_job_counts
INNER JOIN company_dim ON company_job_counts.company_id = company_dim.company_id;
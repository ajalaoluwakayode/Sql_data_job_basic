/* What are the skills required for the top paying Data Analyst jobs?
 Deliverable:
 - Use the top 10 highest-paying Data Analyst roles identified in the previous query.
 - Add the specific skills required for these roles by joining with the skills_dim table.
 - Why? It provides a detailed look at skills in demand for high-paying Data Analyst positions, guiding job seekers on which skills to develop for better career opportunities.
 */
-- Use the top 10 highest-paying Data Analyst roles identified in the previous query to create a CTE (Common Table Expression)
WITH top_pay_data_analyst_jobs AS (
    SELECT job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
) -- Add the specific skills required for these roles by joining with the skills_dim table
SELECT top_pay_data_analyst_jobs.*,
    skills_dim.skills
FROM top_pay_data_analyst_jobs
    INNER JOIN skills_job_dim ON top_pay_data_analyst_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
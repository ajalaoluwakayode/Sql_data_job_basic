/*
 Question: WHat are the top paying Data Analyst jobs?
 Deliverable:
 - Identify the top 10 highest-paying Data Analyst roles that are available remotely.
 - Focus on job postings with specified salaries (remove nulls).
 - why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment trends and potential career paths in the field.
 */
--Identify the top 10 highest-paying Data Analyst roles that are available remotely
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;
--Focus on job postings with specified salaries (remove nulls)
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
-- Include the companies in the name column in the company_dim table
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
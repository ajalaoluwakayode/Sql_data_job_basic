-- January
CREATE TABLE January_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE February_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE March_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- Categorize job location by REMOTE, LOCAL, or ONSITE in a new column called job_location_type
SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'REMOTE'
        WHEN job_location = 'New York, NY' THEN 'LOCAL'
        ELSE 'Onsite'
    END AS job_location_type
FROM job_postings_fact;

-- Filter the above query to only include Data Analyst jobs that are remote
SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'REMOTE'
        WHEN job_location = 'New York, NY' THEN 'LOCAL'
        ELSE 'Onsite'
    END AS job_location_type
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere';

--Using a subquery to create a temporary table of all January job postings, and then selecting all columns from that temporary table
SELECT *
FROM ( -- Subquery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS January_jobs;
-- Subquery ends here

-- Using a subquery to create a temporary table of all January, February, and March job postings, and then selecting specific columns from that temporary table where the average yearly salary is greater than $100,000 and the job title is 'Data Analyst', ordered by average yearly salary
SELECT
    yearQ1_jobs_postings.job_location,
    yearQ1_jobs_postings.job_via,
    yearQ1_jobs_postings.job_posted_date::DATE,
    yearQ1_jobs_postings.salary_year_avg,
    yearQ1_jobs_postings.job_title_short
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS yearQ1_jobs_postings
WHERE
    yearQ1_jobs_postings.salary_year_avg > 100000 AND
    yearQ1_jobs_postings.job_title_short = 'Data Analyst'
ORDER BY
    yearQ1_jobs_postings.salary_year_avg;
/* WHat are the most in-demand skills for Data Analyst roles?
 - Join the job_postings_fact table with the skills_dim table to identify the most frequently listed skills for Data Analyst positions.
 - Identify the top 10 most in-demand skills for Data Analyst roles.
 - Focus on all job psotings and then remote.
 -why? Retreives the top 10 skills with the highest demand in the job market, providing insights into the most sought-after skills for Data Analysts, which can guide job seekers and professionals in skill development for better career opportunities.
 */
-- using a CTE (Common Table Expression) to find the most in-demand skills for Data Analyst roles that are remote
WITH remote_job_skills AS (
    SELECT skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
        INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = True
        AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY skill_id
) -- Select the top 10 most in-demand skills for remote Data Analyst roles
SELECT skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
    INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY skill_count DESC -- Limit to the top 10 most in-demand skills
LIMIT 10;
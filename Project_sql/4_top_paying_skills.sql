/* Top paying skills for Data Analyst
 Answer: What are the top paying skills for Data Analyst roles based on salary data?
 Deliverable:
 - Look at the average salary associated with each skill for Data Analyst roles.
 - Focus on roles with specified salaries, regardless of location
 -why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most lucrative skills to develop for career advancement.
 */
SELECT skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 30;
/*
Business Question:
What are the most optimal skills to learn based on both demand and salary?

Notes:
- Demand is measured by counting how many job postings each skill appears in (demand_count)
- Salary is measured using the average TargetRate_k for jobs that require each skill (avg_salary)
- Skills are ranked by highest demand first, then highest average salary
- This highlights skills that are both widely requested and linked to higher-paying roles

Dataset:
Fictional but realistic recruitment dataset created for portfolio demonstration purposes.
*/

SELECT
    skill.skillid AS skill_id,
    skill.skill_name AS skills,
    COUNT(DISTINCT pipeline.jobid) AS demand_count,
    ROUND(AVG(job.targetrate_k), 2) AS avg_salary
FROM fact_recruitmentpipeline AS pipeline
INNER JOIN dim_job AS job
    ON pipeline.jobid = job.jobid
INNER JOIN bridge_job_skill AS job_skill
    ON pipeline.jobid = job_skill.jobid
INNER JOIN dim_skill AS skill
    ON job_skill.skillid = skill.skillid
GROUP BY
    skill.skillid,
    skill.skill_name
HAVING
    COUNT(DISTINCT pipeline.jobid) > 2
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 10;
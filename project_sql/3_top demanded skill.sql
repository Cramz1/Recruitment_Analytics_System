/*
Business Question:
What are the most in-demand skills across successfully placed roles?

Notes:
- Only roles with a successful placement are included
- Skills are linked to jobs using the bridge table (bridge_job_skill)
- Each skill is counted by how often it appears across placed job postings
- Results return the top 5 most frequently requested skills
- This highlights the skills most associated with real hiring outcomes

Dataset:
Fictional but realistic recruitment dataset created for portfolio demonstration purposes.
*/

SELECT
    skill.skill_name,
    COUNT(DISTINCT pipeline.jobid) AS demand_count
FROM FACT_RecruitmentPipeline AS pipeline
INNER JOIN BRIDGE_Job_Skill AS job_skill
    ON pipeline.jobid = job_skill.jobid
INNER JOIN DIM_Skill AS skill
    ON job_skill.skillid = skill.skillid
GROUP BY
    skill.skill_name
ORDER BY
    demand_count DESC
LIMIT 5;
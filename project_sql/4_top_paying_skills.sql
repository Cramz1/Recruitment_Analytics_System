/*
Business Question:
Which skills are associated with the highest average target compensation?

Notes:
- Jobs are pulled from the recruitment pipeline dataset
- Skills are linked to jobs using BRIDGE_Job_Skill
- Target compensation is averaged (AVG TargetRate_k) per skill
- Results return the top 10 highest-paying skills

Dataset:
Fictional but realistic recruitment dataset created for portfolio demonstration purposes.
*/

SELECT
    skill.skill_name,
    ROUND(AVG(job.targetrate_k), 2) AS avg_target_compensation_k
FROM FACT_RecruitmentPipeline AS pipeline
INNER JOIN DIM_Job AS job
    ON pipeline.jobid = job.jobid
INNER JOIN BRIDGE_Job_Skill AS job_skill
    ON pipeline.jobid = job_skill.jobid
INNER JOIN DIM_Skill AS skill
    ON job_skill.skillid = skill.skillid
GROUP BY
    skill.skill_name
ORDER BY
    avg_target_compensation_k DESC
LIMIT 10;


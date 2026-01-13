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

/*

🔥 1) Engineering / Infrastructure skills are tied to the highest pay

Your top skills are Cloud Data Platforms (88k) + Networking (83.12k) + Linux (82.05k) + Monitoring (83.24k).
➡️ Trend: the closer the role is to production systems + reliability, the higher the target compensation.

🧠 2) “Building solid data foundations” is highly rewarded

Data Modeling (87.37k) + ETL (80.96k) sit high.
➡️ Trend: companies pay more for people who can structure data properly and build pipelines, not only analyze it.

🐍 3) Python is basically the core high-paying skill

Python (86.72k) is near the top.
➡️ Trend: Python connects both worlds: analytics + engineering, so it shows up in higher-paying roles.

🌍 4) Soft skills appear at the very top (this is important)

Customer Communication (88k) being tied #1 is a big signal.
➡️ Trend: top-paying roles often require stakeholder communication + ownership, not just technical work.

📊 5) BI skills pay well, but slightly below “core engineering”

Power BI (81.64k) is strong but not top tier compared to cloud/infrastructure skills.
➡️ Trend: BI is valuable, but the highest pay is more often in data engineering / platform roles.

*/
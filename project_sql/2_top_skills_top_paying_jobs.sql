/*
Business Question:
Which skills are required for the top-paying remote Data job postings?

Notes:
- Only jobs in the Data job category are included (jobcategory = 'Data')
- Only remote work positions are included (is_remote = 'Yes')
- "Top-paying jobs" are defined as the top 3 job postings based on TargetRate_k
- Skills are retrieved via the job-to-skill bridge table (bridge_job_skill)
- Results list each top-paying job with its associated skills, sorted by compensation

Dataset:
Fictional but realistic recruitment dataset created for portfolio demonstration purposes.
*/


WITH remote_data_jobs AS (
    SELECT DISTINCT
        job.jobid,
        job.jobdescription AS job_title,
        work_mode.workmode_name AS work_mode,
        job.targetrate_k AS target_compensation_k
    FROM fact_recruitmentpipeline AS pipeline
    INNER JOIN dim_job AS job
        ON pipeline.jobid = job.jobid
    INNER JOIN dim_workmode AS work_mode
        ON pipeline.workmodeid = work_mode.workmodeid
    WHERE job.jobcategory = 'Data'
      AND work_mode.is_remote = 'Yes'
),
top_paying_jobs AS (
    SELECT *
    FROM remote_data_jobs
    ORDER BY target_compensation_k DESC
    LIMIT 3
)

SELECT
    top_jobs.jobid,
    top_jobs.job_title,
    top_jobs.work_mode,
    top_jobs.target_compensation_k,
    skill.skill_name
FROM top_paying_jobs AS top_jobs
INNER JOIN bridge_job_skill AS job_skill
    ON top_jobs.jobid = job_skill.jobid
INNER JOIN dim_skill AS skill
    ON job_skill.skillid = skill.skillid
ORDER BY
    top_jobs.target_compensation_k DESC,
    top_jobs.job_title,
    skill.skill_name;
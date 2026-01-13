/*
Business Question:
Which remote Data job postings have the highest target compensation?

Notes:
- Jobs are filtered to the Data job category (jobcategory = 'Data')
- Only remote work positions are included (is_remote = 'Yes')
- Compensation is evaluated using TargetRate_k (target salary in thousands)
- Results are sorted from highest to lowest target compensation

Dataset:
Fictional but realistic recruitment dataset created for portfolio demonstration purposes.
*/


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
ORDER BY job.targetrate_k DESC;
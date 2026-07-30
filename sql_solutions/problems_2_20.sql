SELECT 
    COUNT(job_id) AS job_posted_count,
    -- job_title_short AS title,
    -- job_location AS location,
    -- job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS month
    -- EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'    
GROUP BY
    month
ORDER BY
    job_posted_count DESC;


--- solution for PROBLEM 1
SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS yearly,
    AVG(salary_hour_avg) AS hourly
FROM
    job_postings_fact
WHERE 
    (salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL) AND
    job_posted_date::DATE > '2023-06-01'::DATE 
GROUP BY 
    job_schedule_type
    ;            

--- solution for problem 2 
SELECT  
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) AS month,
    COUNT(job_id)
FROM
    job_postings_fact    
WHERE
    job_posted_date >= TIMESTAMP '2023-01-01'
  AND job_posted_date <  TIMESTAMP '2024-01-01'
GROUP BY
    month
ORDER BY 
    month ;    

--- solution for problem 3
--- maybe INNER JOIN suited even better...
SELECT DISTINCT --- <- !!! 'DISTINCT' companies to prevent duplication
    company_dim.name AS company
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id        
WHERE
--     job_posted_date >= TIMESTAMP '2023-04-01'
--   AND job_posted_date <  TIMESTAMP '2024-07-01'
    (EXTRACT(YEAR FROM job_posted_date) = 2023
    AND EXTRACT(QUARTER FROM job_posted_date) = 2)
    AND job_health_insurance = true
;        
    
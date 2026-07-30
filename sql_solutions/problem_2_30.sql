SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg >= 100000.0 THEN 'High'
        WHEN (salary_year_avg > 75000.0 AND salary_year_avg < 100000.0) THEN 'Standard'
        ELSE 'Low'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY
        salary_category;    
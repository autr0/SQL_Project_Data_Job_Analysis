/*
Problem 1:

Identify the top 5 skills that are most frequently mentioned in job
postings. Use a subquery to find the skill IDs with the highest counts 
in the skills_job_dim table and then join this result with the 
skills_dim table to get the skill names
*/

SELECT 
    skills_dim.skills AS skill_name,
    skills_num.skill_count
FROM 
    (
        SELECT 
            COUNT(*) AS skill_count,
            skill_id
        FROM 
            skills_job_dim
        GROUP BY    
            skill_id
        ORDER BY skill_count DESC 
        LIMIT 5   
    ) AS skills_num
LEFT JOIN 
    skills_dim ON skills_num.skill_id = skills_dim.skill_id;
    
/*
Problem 2

Determine the size category ('Small', 'Medium', 'Large') for each company
by first identifying the number of job postings they have. Use a subquery
to calculate the total job postings per company. A company is considered
'Small' if it has less than 10 job postings, 'Medium' if the number of
job postings is between 10 and 50. and 'Large' if it has more than 50 
job postings. Implement a subquery to aggregate job counts per company 
before classifying them based on size

*/

SELECT
    companies.company_name,
    companies.vacancies,
    CASE 
        WHEN companies.vacancies < 10 THEN 'Small'
        WHEN companies.vacancies > 50 THEN 'Large'
        ELSE 'Medium'
    END AS company_size        
FROM (
    SELECT 
        COUNT(job_postings_fact.company_id) AS vacancies,
        company_dim.name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN 
        company_dim ON job_postings_fact.company_id = company_dim.company_id    
    GROUP BY
        company_name
    ORDER BY
        vacancies DESC
) AS companies;
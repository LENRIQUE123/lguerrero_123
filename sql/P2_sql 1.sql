--sql 1
WITH C AS (
SELECT d.departamento,j.job,COUNT(e.id) AS num_hired,quarter(cast((substr(e.datetime,1,4)||'-'||substr(e.datetime,6,2)||'-'||substr(e.datetime,9,2)) as date)) AS quarter
FROM 
    hired_employees e
JOIN 
    jobs j ON e.job_id = j.id
JOIN 
    departments d ON e.department_id = d.id
WHERE 
    substr(e.datetime,1,4) = '2021'
GROUP BY 
    d.departamento, j.job, quarter(cast((substr(e.datetime,1,4)||'-'||substr(e.datetime,6,2)||'-'||substr(e.datetime,9,2)) as date))
ORDER BY 
    d.departamento, j.job
),
Q AS (
select 1 as quarters
union 
select 2
union
select 3
union
select 4
) 

SELECT departamento,job,sum(case when Q.quarters=1 then num_hired else 0 end) q1,
sum(case when Q.quarters=2 then num_hired else 0 end) q2,
sum(case when Q.quarters=3 then num_hired else 0 end) q3,
sum(case when Q.quarters=4 then num_hired else 0 end) q4 FROM C
inner join Q on C.quarter=Q.quarters
group by departamento,job
order by departamento,job



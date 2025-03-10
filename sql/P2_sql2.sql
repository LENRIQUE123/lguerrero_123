SELECT 
    d.id, 
    d.departamento, 
    COUNT(e.id) AS num_employees_hired
FROM 
    departments d
JOIN 
    hired_employees e ON d.id = e.department_id
WHERE 
    substr(e.datetime,1,4) = '2021'
GROUP BY 
    d.id, d.departamento
HAVING 
    COUNT(e.id) > (
        SELECT 
            AVG(dept_count) 
        FROM (
            SELECT 
                COUNT(e.id) AS dept_count
            FROM 
                departments d
            JOIN 
                hired_employees e ON d.id = e.department_id
            WHERE 
                substr(e.datetime,1,4) = '2021'
            GROUP BY 
                d.id
        ) subquery
    )
ORDER BY 
    num_employees_hired DESC


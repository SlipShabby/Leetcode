
# Department Highest Salary

SELECT 
    d.name AS Department, 
    e.name AS Employee, 
    e.salary AS Salary
FROM 
    Employee e
LEFT JOIN
    Department d
ON  
    e.departmentId = d.id
WHERE
    (Salary, d.id) 
IN
    (
        SELECT
            MAX(Salary),
            departmentId
        FROM
            Employee
        GROUP BY
            departmentId
    );


# Consecutive Numbers

SELECT
    DISTINCT num AS ConsecutiveNums
FROM
    (
        SELECT
            id, 
            num,
        lead(num) over (order by id) as next,
        lag(num) over (order by id) as prior
        FROM
            Logs
    ) next_prior
WHERE
    num = next AND num = prior;


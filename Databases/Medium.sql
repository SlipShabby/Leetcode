
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

SELECT
    DISTINCT num AS ConsecutiveNums
FROM
    Logs
WHERE
    (id +1, num)
    IN
        (
            SELECT *
            FROM
                Logs
        )
        AND (id+2, num)
        IN
            (
                SELECT *
                FROM
                    Logs
            );

# Rank Scores

SELECT
    a.score,
    COUNT(b.score) AS 'rank'
FROM Scores a,
    (
        SELECT DISTINCT Score
        FROM
            Scores
    ) b
WHERE a.score <= b.score
GROUP BY a.id, a.score
ORDER BY a.score DESC;
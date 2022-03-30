
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


SELECT
  Score,
  (
      SELECT
        COUNT(*)
      FROM 
      (
          SELECT 
            distinct Score s 
          FROM 
            Scores
      ) tmp 
      WHERE
        s >= Score
  ) 'Rank'
FROM 
    Scores
ORDER BY 
    Score desc;


# second highest salary

SELECT
    Max(salary) AS SecondHighestSalary
FROM 
    Employee
WHERE
    salary NOT IN
(
    SELECT
        MAX(salary)
    FROM Employee e1
);

SELECT
    IFNULL
    (
      (
          SELECT 
            DISTINCT Salary
          FROM 
            Employee
          ORDER BY Salary DESC
          LIMIT 1 OFFSET 1
      ),
    NULL
    ) AS SecondHighestSalary;


# find nth salary

CREATE FUNCTION getNthHighestSalary(N INT)
    RETURNS INT
BEGIN
DECLARE M INT; 
SET M=N-1;
    RETURN
    (
        SELECT
            DISTINCT salary
            FROM Employee
            ORDER BY Salary Desc
            LIMIT 1 OFFSET M
    );
END




# Tree

SELECT
    DISTINCT t1.id,
    (CASE WHEN t1.p_id IS NULL THEN 'Root'
     WHEN t2.id IS NULL THEN 'Leaf' ELSE 'Inner' END
     ) Type
FROM
    Tree t1
LEFT JOIN
    Tree t2
ON t1.id = t2.p_id;


# Swap seats

SELECT
	CASE
		WHEN seat.id % 2 <> 0 AND seat.id = (SELECT COUNT(*) FROM seat) THEN seat.id
		WHEN seat.id % 2 = 0 THEN seat.id - 1
		ELSE
			seat.id + 1
	END as id,
	student 
FROM seat
ORDER BY id
;


# Market Analysis I

SELECT
    u.user_id AS buyer_id,
    join_date,
    COUNT(order_id) AS orders_in_2019
FROM 
    Users u
LEFT JOIN 
    Orders o
ON 
    u.user_id = o.buyer_id
AND 
    o.order_date LIKE '2019%'
GROUP BY 
    u.user_id;
    
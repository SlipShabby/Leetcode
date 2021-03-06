
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


# Capital gains

SELECT 
    stock_name,
    SUM(
        CASE WHEN operation = 'Buy'
        THEN -price
        ELSE price
        END
    ) AS capital_gain_loss
FROM 
    Stocks
GROUP BY 
    stock_name;



#  Human Traffic of Stadium

WITH Visits AS (
    SELECT id,
        visit_date, 
        people, 
        id - ROW_NUMBER() OVER(ORDER BY id) r
    FROM Stadium
    WHERE people >= 100
)

SELECT 
    id, 
    visit_date, 
    people
FROM 
    Visits
WHERE 
    r IN (
            SELECT 
                r 
            FROM
                Visits 
            GROUP BY r
            HAVING COUNT(r) >= 3
    );

# v2

WITH visits AS(
    SELECT *,
        ROW_NUMBER() OVER(ORDER BY id) as row_id
    FROM
        (
            SELECT *
            FROM Stadium
            WHERE people >= 100
        ) t
)

SELECT id, visit_date, people
FROM Stadium,
    (
        SELECT 
            min(id) m, 
            max(id) n 
        FROM
            visits
        GROUP BY 
            id - row_id 
            HAVING COUNT(id-row_id) >=3
    ) t
WHERE id 
    BETWEEN m AND n;

# Department Top Three Salaries

SELECT 
    d1.name AS Department,
    e1.name AS Employee,
    e1.salary AS Salary
FROM 
    Employee e1
JOIN
    Department d1
ON 
    e1.departmentId = d1.id
JOIN
    Department d2
ON d1.id = d2.id

LEFT JOIN
    Employee e2
ON 
    d2.id = e2.departmentId
AND
    e1.salary < e2.salary
GROUP BY d1.name, e1.name, e1.salary
HAVING COUNT(DISTINCT(E2.salary)) <3;


# Trips and Users

WITH t AS (
    SELECT
        request_at,
        T.status <> 'completed' AS Cancelled
    FROM 
        Trips T
    JOIN Users C ON (Client_Id = C.users_id and C.banned = 'No') 
    JOIN Users D ON (Driver_Id = D.users_id and D.banned = 'No') 
    WHERE
        request_at BETWEEN '2013-10-01' AND '2013-10-03'
)


SELECT
    request_at as Day,
    ROUND(CAST(SUM(Cancelled) AS real) / CAST(COUNT(*) AS REAL),2)
    AS 'Cancellation Rate'
FROM
    t
GROUP BY request_at;
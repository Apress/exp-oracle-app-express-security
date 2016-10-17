SELECT
  e.ename,
  d.dname,
  CASE
    WHEN e.deptno = 10 THEN 'green_flag.gif'
    WHEN e.deptno = 20 THEN 'red_flag.gif'
    WHEN e.deptno = 30 THEN 'grey_flag.gif'
    WHEN e.deptno = 40 THEN 'yellow_flag.gif'
    ELSE 'white_flag.gif'
END icon FROM
emp e,
dept d WHERE
  e.deptno = d.deptno
/
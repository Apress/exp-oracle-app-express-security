SELECT
  e.ename,
  CASE
    WHEN e.deptno = 10 THEN '<img src="/i/green_flag.gif"> '
      || d.dname
    WHEN e.deptno = 20 THEN '<img src="/i/red_flag.gif"> '
      || d.dname
    WHEN e.deptno = 30 THEN '<img src="/i/grey_flag.gif"> '
      || d.dname
    WHEN e.deptno = 40 THEN '<img src="/i/yellow_flag.gif"> '
      || d.dname
    ELSE '<img src="/i/white_flag.gif"> ' || d.dname
  END icon
FROM
  emp e,
  dept d 
WHERE
  e.deptno = d.deptno
/
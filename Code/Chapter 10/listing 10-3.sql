SELECT
  ename,
  empno,
  sal 
FROM
  ( 
  SELECT
    ename,
    empno,
    sal
  FROM 
    emp
  ) 
WHERE
  rownum <= CASE
  WHEN :REQUEST IN ('CSV','HTMLD','XLS','PDF','RTF') THEN
    TO_NUMBER(:G_MAX_ROWS)
  ELSE rownum END
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
    WHEN :REQUEST LIKE 'FLOW_EXCEL_OUTPUT%' 
      THEN TO_NUMBER(:G_MAX_ROWS)
      ELSE rownum END
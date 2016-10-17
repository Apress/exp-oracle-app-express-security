CREATE OR REPLACE VIEW emp_v AS
SELECT
  empno,
  ename,
  job,
  deptno
FROM EMP
WITH READ ONLY
/

GRANT SELECT ON emp_v TO shadow
/
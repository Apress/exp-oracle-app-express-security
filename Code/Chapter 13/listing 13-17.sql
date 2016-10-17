CREATE OR REPLACE VIEW emp_v AS
SELECT
  empno,
  ename,
  job,
  deptno
FROM emp
WHERE
  deptno = SYS_CONTEXT('DEPTNO_CTX', 'G_DEPTNO')
WITH READ ONLY
/
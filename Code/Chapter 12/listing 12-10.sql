CREATE OR REPLACE FUNCTION limit_by_deptno
  (
  p_schema     IN VARCHAR2 DEFAULT NULL,
  p_objname    IN VARCHAR2 DEFAULT NULL
  )
RETURN VARCHAR2
AS
  l_sql        VARCHAR2(255);
BEGIN

-- Set the SQL to compare DEPTNO to the application context
l_sql := 'deptno = SYS_CONTEXT(''EMP_VPD_CTX'',''DEPTNO'')';

-- Return the SQL
RETURN l_sql;

END limit_by_deptno;
/
DECLARE
  l_sql VARCHAR2(255);
BEGIN
-- Start the SQL statement
l_sql := 'SELECT * FROM emp';
IF :P1_DEPTNO IS NOT NULL THEN
  -- Apply the filter if a value is provided
  l_sql := l_sql || ' WHERE deptno = ' || :P1_DEPTNO;
ELSE
  -- Otherwise, force the query to return no rows
  l_sql := l_sql || ' WHERE 1=2';
END IF;
-- Print the SQL
htp.p(l_sql);
-- Return the SQL
RETURN l_sql;
END;
/
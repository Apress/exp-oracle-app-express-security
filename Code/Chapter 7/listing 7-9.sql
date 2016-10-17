DECLARE
  l_sql VARCHAR2(255);
BEGIN
-- Start the SQL statement
l_sql := 'SELECT * FROM emp';
-- If P1_ITEM is set to Y, include the WHERE clause
IF :P1_ITEM = 'Y' THEN
  l_sql := l_sql || ' WHERE deptno = 10';
END IF;
-- Return the SQL
RETURN l_sql;
END;
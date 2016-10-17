CREATE OR REPLACE PROCEDURE sqli_fixed_example
  (
  p_ename IN VARCHAR2
  ) 
AS
  l_sql VARCHAR2(100);
  type emp_t IS TABLE OF emp%ROWTYPE;
  emp_r emp_t := emp_t();
BEGIN

-- Assemble the SQL statement with a bind variable
l_sql := 'SELECT * FROM emp WHERE ENAME = :ename';

-- Print the SQL statement about to be executed
DBMS_OUTPUT.PUT_LINE(l_sql);

-- Execute the SQL statement
EXECUTE IMMEDIATE l_sql BULK COLLECT INTO emp_r USING p_ename;

-- Loop through the results and print the name of the employee
IF emp_r.COUNT > 0 THEN
  FOR x IN emp_r.FIRST..emp_r.LAST
  LOOP
    DBMS_OUTPUT.PUT_LINE('Emp: ' || emp_r(x).ename
      || ' - Dept:' || emp_r(x).deptno);
  END LOOP;
ELSE
  DBMS_OUTPUT.PUT_LINE('No Data Found');
END IF;

END sqli_fixed_example;
/
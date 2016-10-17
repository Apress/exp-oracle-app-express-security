CREATE OR REPLACE PROCEDURE sqli_example
  (
  p_ename IN VARCHAR2
  ) 
AS
  l_sql VARCHAR2(100);
  type emp_t IS TABLE OF emp%ROWTYPE;
  emp_r emp_t := emp_t();
BEGIN

-- Concatenate the SQL statement, including quotes
l_sql := 'SELECT * FROM emp WHERE ENAME = '''
  || p_ename || '''';

-- Print the SQL statement about to be executed
DBMS_OUTPUT.PUT_LINE(l_sql);

-- Execute the SQL statement
EXECUTE IMMEDIATE l_sql BULK COLLECT INTO emp_r;

-- Loop through the results and print the name of the employee
FOR x IN emp_r.FIRST..emp_r.LAST
LOOP
  DBMS_OUTPUT.PUT_LINE('Emp: ' || emp_r(x).ename
    || ' - Dept:' || emp_r(x).deptno);
END LOOP;

END sqli_example;
/
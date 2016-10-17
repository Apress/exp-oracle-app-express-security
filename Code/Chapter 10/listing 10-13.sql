PROCEDURE p1_emp_classic IS
BEGIN
mime_header(p_filename => 'emp.csv');
-- Loop through all rows in EMP
FOR x IN (SELECT e.ename, e.empno, d.dname FROM emp e, DEPT d
  WHERE e.deptno = d.deptno)
LOOP
  -- Print out a portion of a row, separated by commas
  -- and ended by a CR
  htp.prn(x.ename ||','|| x.empno ||','|| x.dname || chr(13));
END LOOP;
mime_footer;
END p1_emp_classic;
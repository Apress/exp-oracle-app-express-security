BEGIN
FOR x IN (SELECT ename, job FROM emp ORDER BY ename)
LOOP
  htp.prn(x.ename || ' (' || x.job || ')<br />');
END LOOP;
END;
set serveroutput on;

BEGIN
sqli_example(p_ename => 'KING'' OR ''X'' = ''X');
END;
/
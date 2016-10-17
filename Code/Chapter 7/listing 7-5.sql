set serveroutput on;

begin
sqli_fixed_example(p_ename => 'KING'' OR ''X'' = ''X');
end;
/
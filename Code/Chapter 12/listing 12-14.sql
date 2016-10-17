BEGIN
DBMS_RLS.DROP_POLICY
  (
  object_schema => 'ENKITEC',
  object_name   => 'EMP',
  policy_name   => 'LIMIT_BY_DEPTNO'
  );
END; 
/
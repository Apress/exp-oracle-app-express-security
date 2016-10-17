BEGIN
DBMS_RLS.ADD_POLICY
  (
  object_schema     => 'ENKITEC',
  object_name       => 'EMP',
  policy_name       => 'LIMIT_BY_DEPTNO',
  policy_function   => 'LIMIT_BY_DEPTNO',
  function_schema   => 'ENKITEC',
  sec_relevant_cols => 'SAL,COMM'
  );
END;
/
BEGIN
DBMS_RLS.ADD_POLICY
  (
  object_schema   => 'ENKITEC',
  object_name     => 'EMP',
  policy_name     => 'LIMIT_BY_APP_USER',
  policy_function => 'LIMIT_BY_APP_USER',
  function_schema => 'ENKITEC'
  );
END; 
/
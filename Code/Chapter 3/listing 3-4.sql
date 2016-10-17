SELECT grantee, owner, table_name, privilege
  FROM user_tab_privs
  WHERE privilege NOT IN ('SELECT','EXECUTE')
  AND grantee = 'PUBLIC'
 /
SELECT privilege, count(*)
  FROM user_tab_privs
  WHERE grantee = 'PUBLIC'
  GROUP BY privilege
  ORDER BY 2 DESC
/
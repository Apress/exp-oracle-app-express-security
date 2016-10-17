SELECT module, client_info, client_identifier
  FROM v$session WHERE username = 'APEX_PUBLIC_USER'
/
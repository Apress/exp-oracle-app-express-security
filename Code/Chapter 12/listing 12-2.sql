CREATE OR REPLACE FUNCTION limit_by_username
  (
  p_schema     IN VARCHAR2 DEFAULT NULL,
  p_objname    IN VARCHAR2 DEFAULT NULL
  )
RETURN VARCHAR2
AS
BEGIN
-- Return the SQL
RETURN 'ename = v(''APP_USER'')';
END limit_by_username;
/
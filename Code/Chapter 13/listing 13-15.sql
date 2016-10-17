CREATE OR REPLACE PACKAGE deptno_ctx_pkg
AS
PROCEDURE set_ctx
  (
  p_user_name IN VARCHAR2,
  p_app_session IN VARCHAR2
  );

PROCEDURE unset_ctx
  (
  p_app_session IN VARCHAR2
  );

END deptno_ctx_pkg;
/

CREATE OR REPLACE PACKAGE BODY deptno_ctx_pkg
AS
PROCEDURE set_ctx
  (
  p_user_name IN VARCHAR2,
  p_app_session IN VARCHAR2
  )
IS 
  l_deptno NUMBER;
BEGIN

-- Fetch the DEPTNO based on the currently signed on APP_USER
SELECT deptno INTO l_deptno FROM emp
  WHERE UPPER(ename) = UPPER(p_user_name);

-- Set the Context
dbms_session.set_context(
  namespace => 'DEPTNO_CTX',
  attribute => 'G_DEPTNO',
  value     => l_deptno,
  username  => p_user_name,
  client_id => p_app_session);

EXCEPTION
WHEN no_data_found THEN
  -- If no data is found, then clear the context
  dbms_session.clear_context('DEPTNO_CTX', p_app_session);
END set_ctx;

PROCEDURE unset_ctx
  (
  p_app_session             IN VARCHAR2
  )
IS 
BEGIN
  dbms_session.clear_context('DEPTNO_CTX', p_app_session);
END unset_ctx;

END deptno_ctx_pkg;
/

CREATE OR REPLACE PACKAGE emp_vpd_ctx_pkg
AS
PROCEDURE set_ctx
  (
  p_user_name IN VARCHAR2
  );
PROCEDURE unset_ctx;
END emp_vpd_ctx_pkg;
/

CREATE OR REPLACE PACKAGE BODY emp_vpd_ctx_pkg
AS
PROCEDURE set_ctx
  (
  p_user_name IN VARCHAR2
  )
IS 
  l_deptno NUMBER;
BEGIN

-- Fetch the DEPTNO based on the currently signed on APP_USER
SELECT deptno INTO l_deptno FROM emp
  WHERE UPPER(ename) = UPPER(p_user_name);

-- Set the Context
dbms_session.set_context(
  namespace => 'EMP_VPD_CTX',
  attribute => 'DEPTNO',
  value     => l_deptno);

EXCEPTION
WHEN no_data_found THEN
  -- If no data is found, then clear the context
  dbms_session.clear_context('EMP_VPD_CTX');
END set_ctx;

PROCEDURE unset_ctx
IS
BEGIN

-- Clear the context
dbms_session.clear_context('EMP_VPD_CTX');
END unset_ctx;

END emp_vpd_ctx_pkg;
/
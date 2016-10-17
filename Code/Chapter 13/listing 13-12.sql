GRANT EXECUTE ON data.emp_dml TO shadow
/
CREATE OR REPLACE SYNONYM shadow.emp_dml FOR data.emp_dml
/

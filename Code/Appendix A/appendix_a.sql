DROP TABLE DEPT
/
DROP TABLE EMP
/

CREATE TABLE EMP
  (
  EMPNO NUMBER(4) NOT NULL,
  ENAME VARCHAR2(10),
  JOB VARCHAR2(9),
  MGR NUMBER(4),
  HIREDATE DATE,
  SAL NUMBER(7, 2),
  COMM NUMBER(7, 2),
  DEPTNO NUMBER(2),
  CONSTRAINT EMP_PK PRIMARY KEY (EMPNO) 
  );

INSERT INTO EMP VALUES
  (7369, 'SMITH', 'CLERK', 7902, TO_DATE('17-DEC-1980', 'DD-MON-YYYY'), 800, NULL, 20);
INSERT INTO EMP VALUES
  (7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600, 300, 30);
INSERT INTO EMP VALUES
  (7521, 'WARD', 'SALESMAN', 7698, TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250, 500, 30);
INSERT INTO EMP VALUES
  (7566, 'JONES', 'MANAGER', 7839, TO_DATE('2-APR-1981', 'DD-MON-YYYY'), 2975, NULL, 20);
INSERT INTO EMP VALUES
  (7654, 'MARTIN', 'SALESMAN', 7698, TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO EMP VALUES
  (7698, 'BLAKE', 'MANAGER', 7839, TO_DATE('1-MAY-1981', 'DD-MON-YYYY'), 2850, NULL, 30);
INSERT INTO EMP VALUES
  (7782, 'CLARK', 'MANAGER', 7839, TO_DATE('9-JUN-1981', 'DD-MON-YYYY'), 2450, NULL, 10);
INSERT INTO EMP VALUES
  (7788, 'SCOTT', 'ANALYST', 7566, TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES
  (7839, 'KING', 'PRESIDENT', NULL, TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO EMP VALUES
  (7844, 'TURNER', 'SALESMAN', 7698, TO_DATE('8-SEP-1981', 'DD-MON-YYYY'), 1500, 0, 30);
INSERT INTO EMP VALUES
  (7876, 'ADAMS', 'CLERK', 7788, TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO EMP VALUES
  (7900, 'JAMES', 'CLERK', 7698, TO_DATE('3-DEC-1981', 'DD-MON-YYYY'), 950, NULL, 30);
INSERT INTO EMP VALUES
  (7902, 'FORD', 'ANALYST', 7566, TO_DATE('3-DEC-1981', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMP VALUES
  (7934, 'MILLER', 'CLERK', 7782, TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);


CREATE SEQUENCE emp_seq START WITH 8000;

CREATE OR REPLACE TRIGGER bi_emp
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
  SELECT emp_seq.NEXTVAL INTO  :NEW.empno FROM dual;
END;
/

CREATE TABLE DEPT
  (
  DEPTNO NUMBER(2),
  DNAME VARCHAR2(14),
  LOC VARCHAR2(13) 
  );

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

COMMIT
/

CREATE TABLE export_audit
  (audit_id             NUMBER,
   app_user             VARCHAR2(255),
   app_session          VARCHAR2(255),
   app_id               NUMBER,
   app_page_id          NUMBER,
   region_id            VARCHAR2(255),
   raw_data             VARCHAR2(1000),
   report_type          VARCHAR2(255) DEFAULT 'Standard',
   export_date          DATE,
   CONSTRAINT export_audit_pk PRIMARY KEY (audit_id)
  )
/

CREATE SEQUENCE export_audit_seq START WITH 1
/

create or replace TRIGGER bi_export_audit
BEFORE INSERT ON export_audit
FOR EACH ROW
BEGIN
SELECT export_audit_seq.NEXTVAL INTO :NEW.audit_id FROM dual;
:NEW.app_user    := v('APP_USER');
:NEW.app_session := v('APP_SESSION');
:NEW.app_page_id := nv('APP_PAGE_ID');
:NEW.app_id      := nv('APP_ID');
:NEW.export_date := SYSDATE;
:NEW.raw_data    := :NEW.region_id;

  IF SUBSTR(:NEW.region_id,1,1) = 'R' THEN
    :NEW.region_id := SUBSTR(:NEW.region_id, 2);
  ELSE
    :NEW.region_id := SUBSTR
      (
      :NEW.region_id,
      INSTR(:NEW.region_id, 'FLOW_EXCEL_OUTPUT_R')+19,
      INSTR((SUBSTR(:NEW.region_id, INSTR(:NEW.region_id, 'FLOW_EXCEL_OUTPUT_R')+19)), '_', 1,1 )-1
      );
  END IF;
END;
/

CREATE OR REPLACE PACKAGE custom_export
AS

PROCEDURE export_data
  (
  p_app_id                   IN VARCHAR2,
  p_app_page_id              IN VARCHAR2,
  p_app_session              IN VARCHAR2,
  p_app_user                 IN VARCHAR2,
  p_region_id                IN VARCHAR2 DEFAULT NULL
  );

END custom_export;
/

CREATE OR REPLACE PACKAGE BODY custom_export
AS

--------------------------------------------------------------------------------
-- PROCEDURE: M I M E _ H E A D E R
--------------------------------------------------------------------------------
PROCEDURE mime_header 
  (
  p_filename                 IN VARCHAR2
  )
IS
BEGIN

-- Set the MIME type
owa_util.mime_header( 'application/octet', FALSE );

-- Set the name of the file
htp.p('Content-Disposition: attachment; filename="' || NVL(p_filename, 'export.csv') || '"');

-- Close the HTTP Header
owa_util.http_header_close;

END mime_header;


--------------------------------------------------------------------------------
-- PROCEDURE: M I M E _ F O O T E R
--------------------------------------------------------------------------------
PROCEDURE mime_footer IS
BEGIN

-- Send an error code so that the rest of the HTML does not render
htmldb_application.g_unrecoverable_error := TRUE;

END mime_footer;


--------------------------------------------------------------------------------
-- PROCEDURE: P 1 _ E M P _ C L A S S I C 
--------------------------------------------------------------------------------
PROCEDURE p1_emp_classic IS
BEGIN
mime_header(p_filename => 'emp.csv');
-- Loop through all rows in EMP
FOR x IN (SELECT e.ename, e.empno, d.dname FROM emp e, DEPT d
  WHERE e.deptno = d.deptno)
LOOP
  -- Print out a portion of a row, separated by commas
  -- and ended by a CR
  htp.prn(x.ename ||','|| x.empno ||','|| x.dname || chr(13));
END LOOP;
mime_footer;
END p1_emp_classic;

--------------------------------------------------------------------------------
-- PROCEDURE: P 1 _ E M P _ I N T E R A C T I V E
--------------------------------------------------------------------------------
PROCEDURE p1_emp_interactive IS
BEGIN
mime_header(p_filename => 'emp.csv');
-- Loop through all rows in EMP
FOR x IN (SELECT e.ename, e.empno, d.dname FROM emp e, DEPT d
  WHERE e.deptno = d.deptno)
LOOP
  -- Print out a portion of a row, separated by commas
  -- and ended by a CR
  htp.prn(x.ename ||','|| x.empno ||','|| x.dname || chr(13));
END LOOP;
mime_footer;
END p1_emp_interactive;


--------------------------------------------------------------------------------
-- PROCEDURE: E X P O R T _ D A T A
--------------------------------------------------------------------------------
PROCEDURE export_data
  (
  p_app_id                   IN VARCHAR2,
  p_app_page_id              IN VARCHAR2,
  p_app_session              IN VARCHAR2,
  p_app_user                 IN VARCHAR2,
  p_region_id                IN VARCHAR2 DEFAULT NULL
  )
IS
  l_static_id                VARCHAR2(255);
  l_region_id                VARCHAR2(255) := REPLACE(p_region_id, 'R', NULL);
  l_count                    NUMBER;
  l_page_auth                VARCHAR2(255);
  l_region_auth              VARCHAR2(255);
  l_page_auth_res            BOOLEAN;
  l_region_auth_res          BOOLEAN;
BEGIN

-- First, log the download
-- Determine if the report is Standard or Interactive
SELECT COUNT(*) INTO l_count FROM apex_application_page_ir WHERE region_id = l_region_id;

-- Log the download
IF l_count = 1 THEN
  INSERT INTO export_audit (region_id, report_type) VALUES (p_region_id, 'Interactive');
ELSE
  INSERT INTO export_audit (region_id) VALUES (p_region_id);
END IF;

-- Fetch the Static ID
FOR x IN(SELECT static_id FROM apex_application_page_regions WHERE region_id = l_region_id)
LOOP
  l_static_id := x.static_id;
END LOOP;

IF l_static_id IS NOT NULL THEN

  -- Determine if the user can run the page that the region is located on
  FOR x IN 
    (
    SELECT pr.authorization_scheme region_auth, p.authorization_scheme page_auth
      FROM apex_application_page_regions pr, apex_application_pages p
      WHERE pr.page_id = p.page_id
      AND p.application_id = pr.application_id
      AND pr.region_id = TO_NUMBER(l_region_id)
    ) 
  LOOP
    l_page_auth := x.page_auth;
    l_region_auth := x.region_auth;
  END LOOP;
  
  -- Check to see that the user has access to the page
  IF l_page_auth IS NOT NULL THEN
    l_page_auth_res := APEX_UTIL.PUBLIC_CHECK_AUTHORIZATION(l_page_auth);
  ELSE
    l_page_auth_res := TRUE;
  END IF;
  
  -- Check to see that the user has access to the region
  IF l_region_auth IS NOT NULL THEN
    l_region_auth_res := APEX_UTIL.PUBLIC_CHECK_AUTHORIZATION(l_region_auth);
  ELSE
    l_region_auth_res := TRUE;
  END IF;
   
  -- If the user can't see either the region of page, do not allow the download to start     
  IF l_region_auth_res = FALSE OR l_page_auth_res = FALSE THEN
    -- User can not export this report
    htp.p('You are not Authorized to export this report.'
      || '<br /><a href="f?p=' || p_app_id || ':' || p_app_page_id || ':' 
      || p_app_session || '">Back</a>');
    mime_footer;

  ELSE

    -- Determine which export procedure to run
    CASE 
      WHEN l_static_id = 'p1EmpInteractive' THEN p1_emp_interactive;
      WHEN l_static_id = 'p1EmpClassic' THEN p1_emp_classic;
      ELSE 
        -- No procedure for Static ID
        htp.p('There is no procedure for the static ID ' || l_static_id
          || '<br /><a href="f?p=' || p_app_id || ':' || p_app_page_id || ':' 
          || p_app_session || '">Back to Report</a>');
        mime_footer;
    END CASE;

  END IF;

ELSE
  -- Static ID not found
    htp.p('There is no Static ID defined for this region.'
      || '<br /><a href="f?p=' || p_app_id || ':' || p_app_page_id || ':' 
      || p_app_session || '">Back to Report</a>');
    mime_footer;
END IF;

END export_data;


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
END custom_export;
/

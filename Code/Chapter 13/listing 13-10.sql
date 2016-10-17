create or replace package "EMP_DML" is
--------------------------------------------------------------
-- update procedure for table "EMP"
procedure "UPD_EMP" 
  (
  "P_EMPNO"    in number,
  "P_ENAME"    in varchar2  default null,
  "P_JOB"      in varchar2  default null,
  "P_DEPTNO"   in number    default null,
  "P_MD5"      in varchar2  default null
  );
--------------------------------------------------------------
-- get procedure for table "EMP"
procedure "GET_EMP" 
  (
  "P_EMPNO"    in number,
  "P_ENAME"    out varchar2,
  "P_JOB"      out varchar2,
  "P_DEPTNO"   out number,
  "P_MD5"      out varchar2
  );
--------------------------------------------------------------
-- build MD5 function for table "EMP"
function "BUILD_EMP_MD5" 
  (
  "P_EMPNO"   in number,
  "P_ENAME"   in varchar2  default null,
  "P_JOB"     in varchar2  default null,
  "P_DEPTNO"  in number    default null,
  "P_COL_SEP"  in varchar2  default '|'
   ) return varchar2;
end "EMP_DML";
/

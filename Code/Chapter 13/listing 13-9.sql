create or replace package "EMP_DML" is
--------------------------------------------------------------
-- create procedure for table "EMP"
procedure "INS_EMP" 
  (
  "P_EMPNO"    in number,
  "P_ENAME"    in varchar2  default null,
  "P_JOB"      in varchar2  default null,
  "P_MGR"      in number    default null,
  "P_HIREDATE" in date      default null,
  "P_SAL"      in number    default null,
  "P_COMM"     in number    default null,
  "P_DEPTNO"   in number    default null
   );
--------------------------------------------------------------
-- update procedure for table "EMP"
procedure "UPD_EMP" 
  (
  "P_EMPNO" in number,
  "P_ENAME"    in varchar2  default null,
  "P_JOB"      in varchar2  default null,
  "P_MGR"      in number    default null,
  "P_HIREDATE" in date      default null,    
  "P_SAL"      in number    default null,
  "P_COMM"     in number    default null,
  "P_DEPTNO"   in number    default null,
  "P_MD5"      in varchar2  default null
  );
--------------------------------------------------------------
-- delete procedure for table "EMP"
procedure "DEL_EMP" 
  (
  "P_EMPNO" in number
  );
--------------------------------------------------------------
-- get procedure for table "EMP"
procedure "GET_EMP" 
  (
  "P_EMPNO"    in number,
  "P_ENAME"    out varchar2,
  "P_JOB"      out varchar2,
  "P_MGR"      out number,
  "P_HIREDATE" out date,
  "P_SAL"      out number,
  "P_COMM"     out number,
  "P_DEPTNO"   out number
  );
--------------------------------------------------------------
-- get procedure for table "EMP"
procedure "GET_EMP" 
  (
  "P_EMPNO"    in number,
  "P_ENAME"    out varchar2,
  "P_JOB"      out varchar2,
  "P_MGR"      out number,
  "P_HIREDATE" out date,
  "P_SAL"      out number,
  "P_COMM"     out number,
  "P_DEPTNO"   out number,
  "P_MD5"      out varchar2
   );
--------------------------------------------------------------
-- build MD5 function for table "EMP"
function "BUILD_EMP_MD5" 
  (
  "P_EMPNO" in number,
  "P_ENAME"    in varchar2  default null,
  "P_JOB"      in varchar2  default null,
  "P_MGR"      in number    default null,
  "P_HIREDATE" in date      default null,
  "P_SAL"      in number    default null,
  "P_COMM"     in number    default null,
  "P_DEPTNO"   in number    default null,
  "P_COL_SEP"  in varchar2  default '|'
  ) return varchar2;
end "EMP_DML";
/

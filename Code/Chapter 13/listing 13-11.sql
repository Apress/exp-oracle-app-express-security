create or replace package body "EMP_DML" is
--------------------------------------------------------------
-- update procedure for table "EMP"
procedure "UPD_EMP" 
  (
  "P_EMPNO" in number,
  "P_ENAME"    in varchar2  default null,
  "P_JOB"      in varchar2  default null,
  "P_DEPTNO"   in number    default null,
  "P_MD5"      in varchar2  default null
  ) 
is
  "L_MD5" varchar2(32767) := null;
begin
      if "P_MD5" is not null then
         for c1 in (
            select * from "EMP"
            where "EMPNO" = "P_EMPNO" FOR UPDATE
         ) loop
            "L_MD5" := "BUILD_EMP_MD5"(
               c1."EMPNO",
               c1."ENAME",
               c1."JOB",
               c1."DEPTNO"
         );
         end loop;
      end if;
      if ("P_MD5" is null) or ("L_MD5" = "P_MD5") then
         update "EMP" set
            "EMPNO"      = "P_EMPNO",
            "ENAME"      = "P_ENAME",
            "JOB"        = "P_JOB",
            "DEPTNO"     = "P_DEPTNO"
         where "EMPNO" = "P_EMPNO";
      else
         raise_application_error (-20001,'Current version of data in database has changed since user
initiated update process. current checksum = "'||"L_MD5"||'", item checksum = "'||"P_MD5"||'".');
end if;
end "UPD_EMP";
--------------------------------------------------------------
-- get procedure for table "EMP"
procedure "GET_EMP" 
  (
  "P_EMPNO" in number,
  "P_ENAME"    out varchar2,
  "P_JOB"      out varchar2,
  "P_DEPTNO"   out number,
  "P_MD5"      out varchar2
  ) 
is 
begin
      for c1 in (
         select * from "EMP"
         where "EMPNO" = "P_EMPNO"
      ) loop
   "P_ENAME" := c1."ENAME";
   "P_JOB" := c1."JOB";
   "P_DEPTNO" := c1."DEPTNO";
   "P_MD5" := "BUILD_EMP_MD5"(
            c1."EMPNO",
            c1."ENAME",
            c1."JOB",
            c1."DEPTNO"
      );
end loop;
end "GET_EMP";
--------------------------------------------------------------
-- build MD5 function for table "EMP"
function "BUILD_EMP_MD5" 
  (
  "P_EMPNO"   in number,
  "P_ENAME"   in varchar2 default null,
  "P_JOB"     in varchar2 default null,
  "P_DEPTNO"  in number   default null,
  "P_COL_SEP" in varchar2  default '|'
  ) 
return varchar2 is
begin
return sys.utl_raw.cast_to_raw(sys.dbms_obfuscation_toolkit.md5(input_string=>
  "P_ENAME"  || "P_COL_SEP"||
  "P_JOB"    || "P_COL_SEP"||
  "P_DEPTNO" || "P_COL_SEP"));
end "BUILD_EMP_MD5";

end "EMP_DML";
/

apex_collection.create_or_truncate_collection
  (
  p_collection_name => 'EMP_E'
  );
FOR x IN (SELECT * FROM emp)
LOOP
  apex_collection.add_member
  (
    p_collection_name => 'EMP_E',
    p_c001 => x.empno,
    p_c002 => x.ename,
    p_blob001 => encrypt_collection_pkg.encrypt_data(x.sal)
  );
END LOOP;
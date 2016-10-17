SELECT
  c001,
  c002,
  encrypt_collection_pkg.decrypt_data(blob001) sal
FROM
  apex_collections
WHERE
  collection_name = 'EMP_E'
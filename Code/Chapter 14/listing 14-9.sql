SELECT
  c001,
  c002,
  encrypt_collection_pkg.decrypt_data(blob001) sal,
  utl_i18n.raw_to_char
    (
    data => blob001,
    src_charset => 'AL32UTF8'
    ) sal_encrypted
FROM
  apex_collections
WHERE
  collection_name = 'EMP_E'
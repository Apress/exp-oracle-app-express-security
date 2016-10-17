CREATE OR REPLACE PACKAGE encrypt_collection_pkg
AS
FUNCTION encrypt_data
  (
  p_data IN VARCHAR2
  )
RETURN RAW;

FUNCTION decrypt_data
  (
  p_data IN RAW
  )
RETURN VARCHAR2;

END encrypt_collection_pkg;
/

CREATE OR REPLACE PACKAGE BODY encrypt_collection_pkg
AS
  g_character_set    VARCHAR2(10)  := 'AL32UTF8';
  g_encryption_type  PLS_INTEGER   :=
    dbms_crypto.encrypt_aes256 +
    dbms_crypto.chain_cbc +
    dbms_crypto.pad_pkcs5;
  g_key              RAW(32)       :=
    UTL_I18N.STRING_TO_RAW(v('P1_EMP_KEY'));

FUNCTION encrypt_data
  (p_data IN VARCHAR2)
RETURN RAW
IS
BEGIN
RETURN dbms_crypto.encrypt
  (
  src => utl_i18n.string_to_raw
    (
    data        => p_data,
    dst_charset => g_character_set
    ),
  typ => g_encryption_type,
  key => g_key
  );
END encrypt_data;

FUNCTION decrypt_data
  (p_data IN RAW)
RETURN VARCHAR2
IS
BEGIN
RETURN utl_i18n.raw_to_char
  (
  data        => dbms_crypto.decrypt
    (
    src => p_data,
    typ => g_encryption_type,
    key => g_key
    ),
  src_charset => g_character_set
  );

EXCEPTION
WHEN OTHERS THEN
  raise_application_error(-20000,'Invalid Key.');
END decrypt_data;

END encrypt_collection_pkg;
/

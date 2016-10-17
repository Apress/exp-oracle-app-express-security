SELECT
  flow_id application_id,
  item_name,
  is_encrypted,
  item_value_vc2
FROM
  wwv_flow_data
WHERE
  item_name = 'P3_SAL'
/
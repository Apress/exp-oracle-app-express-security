declare
  PRAGMA AUTONOMOUS_TRANSACTION;
begin
  wwv_flow_api.set_security_group_id
    (
    p_security_group_id => 1044509116395059
    );
  wwv_flow_api.set_flow_status
    (
    p_flow_id      => 117,
    p_flow_status  => 'AVAILABLE'
    );
commit; 
end;
/
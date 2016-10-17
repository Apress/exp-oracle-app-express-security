BEGIN
	APEX_INSTANCE_ADMIN.SET_PARAMETER
     (
     p_parameter => 'REQUIRE_HTTPS',
     p_value => 'N'
     );
END;
/

wwv_flow_custom_auth_std.login(
    P_UNAME       => v('P101_USERNAME'),
    P_PASSWORD    => :P101_PASSWORD,
    P_SESSION_ID  => v('APP_SESSION'),
    P_FLOW_PAGE   => :APP_ID||':1'
    );
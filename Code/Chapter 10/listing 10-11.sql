-- If the user can't see either the region of page,
-- then do not allow the download to start
IF l_region_auth_res = FALSE OR l_page_auth_res = FALSE THEN
  -- User cannot export this report
  htp.p('You are not Authorized to export this report.'
    || '<br /><a href="f?p=' || p_app_id || ':'
    || p_app_page_id || ':' || p_app_session || '">Back</a>');
  mime_footer;
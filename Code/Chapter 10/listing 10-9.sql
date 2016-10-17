IF l_static_id IS NOT NULL THEN
  ...
ELSE
  -- Static ID not found
    htp.p('There is no Static ID defined for this region.'
      || '<br /><a href="f?p=' || p_app_id || ':'
      || p_app_page_id || ':' || p_app_session
      || '">Back to Report</a>');
    mime_footer;
END IF;
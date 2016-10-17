ELSE
  -- Determine which export procedure to run
  CASE
    WHEN l_static_id = 'p1EmpClassic' THEN p1_emp_classic;
    WHEN l_static_id = 'p1EmpInteractive' THEN p1_emp_interactive;
 ELSE
   -- No procedure for Static ID
   htp.p('There is no procedure for the static ID'
    || l_static_id
    || '<br /><a href="f?p=' || p_app_id || ':'
    || p_app_page_id || ':' || p_app_session
    || '">Back to Report</a>');
    mime_footer;
  END CASE;
END IF;
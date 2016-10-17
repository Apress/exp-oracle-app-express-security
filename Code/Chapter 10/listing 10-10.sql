-- Determine if the user can run the page that the region is located on
FOR x IN
  ( 
  SELECT
    pr.authorization_scheme region_auth,
    p.authorization_scheme page_auth
  FROM
    apex_application_page_regions pr,
    apex_application_pages p
  WHERE
    pr.page_id = p.page_id
    AND p.application_id = pr.application_id
    AND pr.region_id = TO_NUMBER(l_region_id)
    AND p.application_id = p_app_id)
  ) 
LOOP
  l_page_auth := x.page_auth;
  l_region_auth := x.region_auth;
END LOOP;
-- Check to see that the user has access to the page
IF l_page_auth IS NOT NULL THEN
  l_page_auth_res := APEX_UTIL.PUBLIC_CHECK_AUTHORIZATION(l_page_auth);
ELSE
  l_page_auth_res := TRUE;
END IF;
-- Check to see that the user has access to the region
IF l_region_auth IS NOT NULL THEN
  l_region_auth_res := APEX_UTIL.PUBLIC_CHECK_AUTHORIZATION(l_region_auth);
ELSE
  l_region_auth_res := TRUE;
END IF;
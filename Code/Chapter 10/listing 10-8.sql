 -- Fetch the Static ID
FOR x IN (SELECT static_id FROM apex_application_page_regions
  WHERE region_id = l_region_id)
LOOP
  l_static_id := x.static_id;
END LOOP;
-- Determine if the report is Classic or Interactive
SELECT COUNT(*) INTO l_count FROM apex_application_page_ir
  WHERE region_id = l_region_id;
-- Log the download
IF l_count = 1 THEN
  INSERT INTO export_audit (region_id, report_type)
    VALUES (p_region_id, 'Interactive');
ELSE
  INSERT INTO export_audit (region_id) VALUES (p_region_id);
END IF;
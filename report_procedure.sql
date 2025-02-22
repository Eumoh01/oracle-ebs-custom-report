-- Create a function that generates a formatted PO report with parameters
CREATE OR REPLACE FUNCTION generate_po_report(
    p_start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP - INTERVAL '30 days',  -- Start of date range
    p_end_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                         -- End of date range
    p_min_amount NUMERIC DEFAULT 0                                         -- Minimum PO amount filter
)
RETURNS TABLE (
    report_line TEXT    -- Each line of the report will be returned as text
) AS $$
BEGIN
    -- Generate report header with parameters
    RETURN QUERY SELECT '=== PURCHASE ORDER REPORT ===';
    RETURN QUERY SELECT 'Date Range: ' || p_start_date::DATE || ' to ' || p_end_date::DATE;
    RETURN QUERY SELECT 'Minimum Amount: $' || p_min_amount;
    RETURN QUERY SELECT '==============================';
    RETURN QUERY SELECT '';

    -- Generate the main report data
    -- Joins all three tables and formats each row as a text line
    RETURN QUERY 
    SELECT 
        'PO: ' || poh.segment1 || 
        ' | Vendor: ' || pov.vendor_name || 
        ' | Amount: $' || TO_CHAR(SUM(pol.quantity * pol.unit_price), '999,999.99') ||
        ' | Lines: ' || COUNT(pol.po_line_id)::TEXT
    FROM 
        po_headers_all poh
    JOIN 
        po_lines_all pol ON poh.po_header_id = pol.po_header_id    -- Link PO lines to headers
    JOIN 
        po_vendors pov ON poh.vendor_id = pov.vendor_id            -- Link vendors to POs
    WHERE 
        poh.creation_date BETWEEN p_start_date AND p_end_date      -- Filter by date range
        AND (pol.quantity * pol.unit_price) >= p_min_amount        -- Filter by minimum amount
    GROUP BY 
        poh.segment1, pov.vendor_name                              -- Group by PO and vendor
    ORDER BY 
        poh.segment1;                                              -- Sort by PO number

    -- Add footer to the report
    RETURN QUERY SELECT '';
    RETURN QUERY SELECT '=== END OF REPORT ===';
END;
$$ LANGUAGE plpgsql; 
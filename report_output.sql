-- Option 1: CSV Format Output
-- This format is suitable for Excel or data analysis
SELECT 
    poh.segment1 AS "PO Number",
    pov.vendor_name AS "Vendor",
    pol.item_description AS "Item",
    pol.quantity AS "Quantity",
    pol.unit_price AS "Unit Price",
    pol.quantity * pol.unit_price AS "Total Amount",
    poh.creation_date AS "Created On"
FROM 
    po_headers_all poh
JOIN 
    po_lines_all pol ON poh.po_header_id = pol.po_header_id
JOIN 
    po_vendors pov ON poh.vendor_id = pov.vendor_id
WHERE 
    poh.creation_date >= CURRENT_TIMESTAMP - INTERVAL '30 days'
ORDER BY 
    poh.creation_date DESC;

-- Option 2: HTML Format Output
-- This format creates a table suitable for web display
SELECT 
    '<tr>' ||
    '<td>' || poh.segment1 || '</td>' ||
    '<td>' || pov.vendor_name || '</td>' ||
    '<td>' || pol.item_description || '</td>' ||
    '<td>' || pol.quantity || '</td>' ||
    '<td>$' || TO_CHAR(pol.unit_price, '999,999.99') || '</td>' ||
    '<td>$' || TO_CHAR(pol.quantity * pol.unit_price, '999,999.99') || '</td>' ||
    '<td>' || TO_CHAR(poh.creation_date, 'YYYY-MM-DD') || '</td>' ||
    '</tr>' AS "HTML_ROW"
FROM 
    po_headers_all poh
JOIN 
    po_lines_all pol ON poh.po_header_id = pol.po_header_id
JOIN 
    po_vendors pov ON poh.vendor_id = pov.vendor_id
WHERE 
    poh.creation_date >= CURRENT_TIMESTAMP - INTERVAL '30 days'
ORDER BY 
    poh.creation_date DESC; 
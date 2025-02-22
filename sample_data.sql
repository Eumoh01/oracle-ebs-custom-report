-- Insert sample data

-- Insert three sample vendors into the vendors table
INSERT INTO po_vendors (vendor_id, vendor_name) VALUES 
    (1, 'ABC Supplies'),
    (2, 'XYZ Corp'),
    (3, 'Tech Gadgets Inc');

-- Create three purchase orders, each from a different vendor
-- Uses CURRENT_TIMESTAMP with intervals to create different dates
INSERT INTO po_headers_all (po_header_id, segment1, vendor_id, creation_date) VALUES 
    (1001, 'PO-2025001', 1, CURRENT_TIMESTAMP - INTERVAL '10 days'),
    (1002, 'PO-2025002', 2, CURRENT_TIMESTAMP - INTERVAL '5 days'),
    (1003, 'PO-2025003', 3, CURRENT_TIMESTAMP - INTERVAL '2 days');

-- Create line items for each purchase order
-- Each PO has one line item with different quantities and prices
INSERT INTO po_lines_all (po_line_id, po_header_id, item_description, quantity, unit_price) VALUES 
    (2001, 1001, 'Office Chair', 10, 150.00),    -- Total: $1,500
    (2002, 1002, 'Laptop Stand', 20, 45.00),     -- Total: $900
    (2003, 1003, 'Wireless Mouse', 50, 25.00);   -- Total: $1,250 
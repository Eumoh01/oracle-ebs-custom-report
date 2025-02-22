-- Create mock EBS tables

-- Create the main Purchase Order header table to store PO metadata
CREATE TABLE po_headers_all (
    po_header_id SERIAL PRIMARY KEY,  -- Auto-incrementing unique identifier
    segment1 VARCHAR(50),             -- PO number (e.g., PO-2025001)
    vendor_id INTEGER,                -- Reference to vendor/supplier
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- When PO was created
);

-- Create the Purchase Order lines table to store individual items in each PO
CREATE TABLE po_lines_all (
    po_line_id SERIAL PRIMARY KEY,    -- Auto-incrementing unique identifier
    po_header_id INTEGER REFERENCES po_headers_all(po_header_id),  -- Link to parent PO
    item_description VARCHAR(255),     -- Description of item being purchased
    quantity NUMERIC,                  -- How many items ordered
    unit_price NUMERIC(15,2)          -- Price per unit (allows 2 decimal places)
);

-- Create the vendors table to store supplier information
CREATE TABLE po_vendors (
    vendor_id SERIAL PRIMARY KEY,     -- Auto-incrementing unique identifier
    vendor_name VARCHAR(100)          -- Name of the vendor/supplier
); 
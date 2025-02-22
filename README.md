# Oracle EBS-Style Purchase Order Report

## Overview
This project simulates Oracle E-Business Suite (EBS) Purchase Order functionality using PostgreSQL, demonstrating my understanding of EBS concepts and data structures without requiring an actual EBS installation. While the implementation uses PostgreSQL for accessibility, the table structures, naming conventions, and SQL patterns mirror those found in Oracle EBS, showcasing my ability to work with EBS-style systems.

The project includes mock versions of key EBS tables (PO_HEADERS_ALL, PO_LINES_ALL), follows EBS naming conventions, and implements reporting functionality similar to EBS concurrent programs. This approach demonstrates both technical SQL skills and understanding of EBS business processes and data modeling.

## Prerequisites
- Docker
- DBeaver or any PostgreSQL client

## Quick Start
1. Clone this repository:
   ```bash
   git clone https://github.com/eumoh/oracle-ebs-custom-report.git
   cd oracle-ebs-custom-report
   ```

2. Start the database:
   ```bash
   docker-compose up -d
   ```

3. Connect to the database:
   - Host: localhost
   - Port: 5433
   - Database: postgres
   - Username: postgres
   - Password: Welcome123

4. Run the report:
   ```sql
   SELECT * FROM generate_po_report(
       CURRENT_TIMESTAMP - INTERVAL '30 days',
       CURRENT_TIMESTAMP,
       100
   );
   ```

## Project Structure
- `schema.sql`: Table definitions
- `sample_data.sql`: Test data
- `report_procedure.sql`: Report generation procedure
- `docker-compose.yml`: Container configuration
- `report_output.sql`: CSV and HTML report format examples

## Technical Highlights
- EBS-style data modeling (PO_HEADERS_ALL, PO_LINES_ALL tables)
- Concurrent program simulation with parameterized reporting
- Multiple output formats (CSV, HTML) following EBS patterns
- Docker containerization for easy deployment
- Complex SQL operations (joins, aggregations, formatting)
- Business process implementation (purchase order workflow)
**📦 Oracle Inventory Management Backend**
  A modular, production-ready Oracle 19c+ backend for inventory systems using advanced PL/SQL design.
  Includes relational modeling, reusable packages, error logging, and performance-focused features.

**🧭 Project Overview**
  This repository showcases an enterprise-style Oracle database backend for inventory management. It's ideal for developers, DBAs, and technical interview prep—demonstrating:

    ✅ Relational schema with referential integrity and meaningful constraints

    📦 Modular PL/SQL packages: CRUD, reporting, validation, and logging

    🔒 Transaction safety with autonomous error logging

    🚀 Performance features: bulk processing, dynamic SQL, %TYPE, and exception control

    📊 Utility-driven design for real-world business use cases



**🗂️ Repository Structure**

      oracle-inventory-backend/

      ├── schema/

      │   ├── tables.sql          # Table definitions with constraints & comments
  
      │   ├── indexes.sql         # Performance-boosting indexes
  
      │   └── sample_data.sql     # Preloaded sample data

      ├── packages/

      │   ├── crud_operations_pkg.sql   # Core inventory logic
  
      │   ├── reporting_pkg.sql         # Reporting utilities with ref cursors

      │   └── utilities_pkg.sql         # Validation and error logging
    
      ├── tests/
  
      │   ├── test_crud.sql       # Demos for CRUD operations

      │   └── test_reports.sql    # Reporting outputs and ref cursors

      └── README.md               # Project overview and usage guide


**🏗️ Database Schema Highlights**

    products: Product master table

    categories: Product types

    warehouses: Warehouse location metadata

    inventory: Tracks stock across products/warehouses

    suppliers: Vendor master

    transactions: Logs stock-in/out activities

    error_log: Stores system and business logic errors with timestamps



**🔐 Designed with:**

    Primary/foreign keys

    Cascading deletes

    Indexed lookups

**Validation-ready structure**

    🧩 PL/SQL Package Breakdown
    🔧 utilities_pkg
    
**Utility layer reused across packages:**

    log_error: Logs custom or unexpected errors (uses autonomous transaction)

    validate_email, validate_phone: Regex-based validation

        📦 crud_operations_pkg
        Handles inventory state changes:
        add_item, update_stock, delete_product: Controlled insert/update/delete logic

    check_availability, calculate_value: Reusable business queries

        📊 reporting_pkg
        Reporting and data exports:
        generate_monthly_sales: Returns sales summary using ref cursor
        get_top_products: Ranked sales report by quantity/value
        calculate_profit: Sample revenue-cost logic
        export_to_csv: (Text-formatted demo for file-based export)


**🧠 Key Features & Practices**

| Feature                         | Purpose                                        |
| ------------------------------- | ---------------------------------------------- |
| `%TYPE`                         | Tightly couples parameters with schema changes |
| `BULK COLLECT`                  | Optimizes batch queries                        |
| `PRAGMA AUTONOMOUS_TRANSACTION` | Allows error logging even on rollback          |
| `REF CURSOR`                    | Flexible report outputs                        |
| `DYNAMIC SQL`                   | Enables flexible WHERE/order conditions        |
| `DBMS_OUTPUT`                   | Useful for debug logs and test outputs         |


**🚀 Quick Start Guide**

**✅ 1. Create Schema & Sample Data**
      @schema/tables.sql
      @schema/indexes.sql
      @schema/sample_data.sql

**📦 2. Compile PL/SQL Packages (in order)**
      @packages/utilities_pkg.sql
      @packages/crud_operations_pkg.sql
      @packages/reporting_pkg.sql

**🧪 3. Run Test Scripts**
      -- CRUD operations
      @tests/test_crud.sql

      -- Reporting examples
      @tests/test_reports.sql

**📚 Best Practices Followed**
      Uses %TYPE and %ROWTYPE for future-proof code

      Exception blocks in every procedure/function

      Logging includes error context, timestamp, and procedure

      Ref cursors used for loose-coupled report generation

      Modularized for clarity and testability

**🛠️ Customization Tips**

      🔄 Expand transactions to include batch entries or approval workflows

      🌍 Add multi-currency or tax handling to product-level metadata

      🧾 Improve reporting with pivot-style or parameterized filters

      🧪 Integrate with APEX or RESTful APIs for UI layer

**📝 Documentation Conventions**
      
      Each script includes a header (purpose, author, changelog)

      Comments use Oracle-recommended formatting for procedures/functions

      Tests use DBMS_OUTPUT to show meaningful intermediate and final results

**🤝 Credits**

      Developed as a demonstration of clean, maintainable Oracle backend design.

      Author: Aaron Mathew

      Date: July 18, 2025

      License: MIT License

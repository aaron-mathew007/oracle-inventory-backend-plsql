-- Comments (for Documentation)
COMMENT ON TABLE products IS 'Product master data';
COMMENT ON COLUMN inventory.quantity_on_hand IS 'Currently available stock in warehouse';

-- Sample Data Inserts
INSERT INTO categories (name, description) VALUES ('Electronics', 'Electronic gadgets');
INSERT INTO categories (name, description) VALUES ('Furniture', 'Tables, Chairs, Sofas');

INSERT INTO suppliers (name, email, phone) VALUES ('Global Supplies', 'contact@global.com', '123-456-7890');
INSERT INTO suppliers (name, email, phone) VALUES ('FurnishNow', 'sales@furnishnow.com', '321-654-0987');

INSERT INTO products (category_id, supplier_id, product_name, unit_price)
VALUES (1, 1, 'Smartphone', 350.00);
INSERT INTO products (category_id, supplier_id, product_name, unit_price)
VALUES (2, 2, 'Office Chair', 80.00);

INSERT INTO warehouses (name, location) VALUES ('East Warehouse', 'New York');
INSERT INTO warehouses (name, location) VALUES ('West Warehouse', 'San Francisco');

INSERT INTO inventory (product_id, warehouse_id, quantity_on_hand)
VALUES (1, 1, 100);
INSERT INTO inventory (product_id, warehouse_id, quantity_on_hand)
VALUES (2, 2, 50);

/* 
   Package: CRUD_OPERATIONS_PKG
   Purpose: Encapsulate CRUD operations for inventory
   Author: Aaron Mathew
   Change Log: 2025-07-18 Created
*/
CREATE OR REPLACE PACKAGE crud_operations_pkg AS

  -- Adds a new inventory item.
  PROCEDURE add_item(
    p_product_id   IN inventory.product_id%TYPE,
    p_warehouse_id IN inventory.warehouse_id%TYPE,
    p_quantity     IN inventory.quantity_on_hand%TYPE
  );

  -- Updates the quantity on hand for an inventory record.
  PROCEDURE update_stock(
    p_inventory_id IN inventory.inventory_id%TYPE,
    p_quantity     IN inventory.quantity_on_hand%TYPE
  );

  -- Deletes a product (cascades delete on inventory).
  PROCEDURE delete_product(
    p_product_id IN products.product_id%TYPE
  );

  -- Checks if a product is available in any warehouse.
  FUNCTION check_availability(
    p_product_id IN products.product_id%TYPE
  ) RETURN BOOLEAN;

  -- Calculates total value of inventory for a product.
  FUNCTION calculate_value(
    p_product_id IN products.product_id%TYPE
  ) RETURN NUMBER;

END crud_operations_pkg;
/

/* Package Body: */

CREATE OR REPLACE PACKAGE BODY crud_operations_pkg AS
  PROCEDURE add_item(
    p_product_id   IN inventory.product_id%TYPE,
    p_warehouse_id IN inventory.warehouse_id%TYPE,
    p_quantity     IN inventory.quantity_on_hand%TYPE
  ) IS
  BEGIN
    INSERT INTO inventory(product_id, warehouse_id, quantity_on_hand)
    VALUES (p_product_id, p_warehouse_id, p_quantity);
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      utilities_pkg.log_error('CRUD_OPERATIONS_PKG', 'Duplicate inventory.', 'add_item');
      RAISE_APPLICATION_ERROR(-20001, 'Inventory for product and warehouse exists.');
  END;

  PROCEDURE update_stock(
    p_inventory_id IN inventory.inventory_id%TYPE,
    p_quantity     IN inventory.quantity_on_hand%TYPE
  ) IS
  BEGIN
    UPDATE inventory SET quantity_on_hand = p_quantity
    WHERE inventory_id = p_inventory_id;
    IF SQL%ROWCOUNT = 0 THEN
      utilities_pkg.log_error('CRUD_OPERATIONS_PKG', 'Inventory not found.', 'update_stock');
      RAISE_APPLICATION_ERROR(-20002, 'Inventory ID not found.');
    END IF;
  END;

  PROCEDURE delete_product(
    p_product_id IN products.product_id%TYPE
  ) IS
  BEGIN
    DELETE FROM inventory WHERE product_id = p_product_id;
    DELETE FROM products WHERE product_id = p_product_id;
    /* TODO: Customize - handle more dependencies */
  EXCEPTION
    WHEN OTHERS THEN
      utilities_pkg.log_error('CRUD_OPERATIONS_PKG', SQLERRM, 'delete_product');
      RAISE;
  END;

  FUNCTION check_availability(
    p_product_id IN products.product_id%TYPE
  ) RETURN BOOLEAN IS
    v_count NUMBER;
  BEGIN
    SELECT COUNT(*) INTO v_count FROM inventory WHERE product_id = p_product_id AND quantity_on_hand > 0;
    RETURN v_count > 0;
  END;

  FUNCTION calculate_value(
    p_product_id IN products.product_id%TYPE
  ) RETURN NUMBER IS
    v_total NUMBER := 0;
  BEGIN
    SELECT SUM(i.quantity_on_hand * p.unit_price)
    INTO v_total
    FROM inventory i
    JOIN products p ON i.product_id = p.product_id
    WHERE i.product_id = p_product_id;
    RETURN NVL(v_total, 0);
  END;

END crud_operations_pkg;
/

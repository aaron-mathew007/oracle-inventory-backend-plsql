DECLARE
  v_check BOOLEAN;
  v_value NUMBER;
BEGIN
  -- Add an item
  crud_operations_pkg.add_item(1, 2, 10);

  -- Update stock
  crud_operations_pkg.update_stock(1, 250);

  -- Check availability
  v_check := crud_operations_pkg.check_availability(1);
  DBMS_OUTPUT.PUT_LINE('Available? ' || CASE WHEN v_check THEN 'Yes' ELSE 'No' END);

  -- Calculate total value
  v_value := crud_operations_pkg.calculate_value(1);
  DBMS_OUTPUT.PUT_LINE('Inventory total value: ' || v_value);

  -- Delete a product
  crud_operations_pkg.delete_product(2);
END;

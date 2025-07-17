DECLARE
  rc SYS_REFCURSOR;
  pname VARCHAR2(400);
  tot NUMBER;
BEGIN
  -- Generate monthly sales
  reporting_pkg.generate_monthly_sales(2025, 7, rc);
  LOOP
    FETCH rc INTO pname, tot;
    EXIT WHEN rc%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(pname || ': ' || tot);
  END LOOP;
  CLOSE rc;

  -- Export to CSV
  reporting_pkg.export_to_csv(1);

  -- Get top products
  rc := reporting_pkg.get_top_products(3);
  LOOP
    FETCH rc INTO pname, tot;
    EXIT WHEN rc%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Top: ' || pname || ' -- ' || tot);
  END LOOP;
  CLOSE rc;

  -- Calculate profit
  DBMS_OUTPUT.PUT_LINE('Profit: ' || reporting_pkg.calculate_profit(1));
END;

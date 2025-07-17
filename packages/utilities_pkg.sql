/*
   Package: UTILITIES_PKG
   Purpose: Utility subroutines: error logging (with autonomous tx), validation
   Author: Aaron Mathew
   Change Log: 2025-07-18 Created
*/

CREATE OR REPLACE PACKAGE utilities_pkg AS

  -- Logs error; autonomous transaction
  PROCEDURE log_error(
    p_module        IN VARCHAR2,
    p_error_message IN VARCHAR2,
    p_context       IN VARCHAR2 := NULL
  );

  -- Validates email address.
  FUNCTION validate_email(
    p_email IN suppliers.email%TYPE
  ) RETURN BOOLEAN;

  -- Validates phone number (simple pattern).
  FUNCTION validate_phone(
    p_phone IN suppliers.phone%TYPE
  ) RETURN BOOLEAN;

END utilities_pkg;
/

/* Package Body: */
CREATE OR REPLACE PACKAGE BODY utilities_pkg AS

  PROCEDURE log_error(
    p_module        IN VARCHAR2,
    p_error_message IN VARCHAR2,
    p_context       IN VARCHAR2 := NULL
  ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
  BEGIN
    INSERT INTO error_log(module, error_message, custom_context)
    VALUES (p_module, substr(p_error_message,1,4000), p_context);
    COMMIT;
  END;

  FUNCTION validate_email(
    p_email IN suppliers.email%TYPE
  ) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
  END;

  FUNCTION validate_phone(
    p_phone IN suppliers.phone%TYPE
  ) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_phone, '^[\d\-+\s]{7,20}$');
  END;

END utilities_pkg;
/

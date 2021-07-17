CREATE OR REPLACE PROCEDURE transfer_budgets
  ( in_budget_from INTEGER
  , in_budget_to INTEGER
  , in_amount NUMBER
)
IS
BEGIN
  UPDATE budgets
  SET amount = amount - in_amount
  WHERE b_id = in_budget_from;
  UPDATE budgets
  SET amount = amount + amount
  WHERE b_id = in_budget_to;
  DBMS_OUTPUT.PUT_LINE(in_amount || ' was transferred from budget ' 
                     || in_budget_from || ' to budget ' 
                     || in_budget_to || '.'); 
  COMMIT;
END;
/
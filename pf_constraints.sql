ALTER TABLE expenses
  ADD CONSTRAINT exp_cat_exp_fk FOREIGN KEY ( expense_category )
    REFERENCES expense_categories ( exp_cat_id )
    ON DELETE CASCADE;

ALTER TABLE expenses
  ADD CONSTRAINT acc_exp_fk FOREIGN KEY ( account )
    REFERENCES accounts ( acc_id )
    ON DELETE SET NULL;

ALTER TABLE expense_categories
  ADD CONSTRAINT b_exp_cat_fk FOREIGN KEY ( budget )
    REFERENCES budgets ( b_id )
    ON DELETE CASCADE;

ALTER TABLE budgets
  ADD CONSTRAINT b_cat_b_fk FOREIGN KEY ( budget_category )
    REFERENCES budget_categories ( b_cat_id )
    ON DELETE CASCADE;


ALTER TABLE accounts
  ADD CONSTRAINT acc_types_acc_fk FOREIGN KEY ( account_type )
    REFERENCES account_types ( acc_type_id )
    ON DELETE CASCADE;

ALTER TABLE incomes
  ADD CONSTRAINT inc_cat_inc_fk FOREIGN KEY ( income_category )
    REFERENCES income_categories ( inc_cat_id )
    ON DELETE CASCADE;

ALTER TABLE incomes
  ADD CONSTRAINT acc_inc_fk FOREIGN KEY ( account )
    REFERENCES accounts ( acc_id )
    ON DELETE CASCADE;

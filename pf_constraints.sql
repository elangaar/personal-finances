ALTER TABLE expense_categories
    ADD CONSTRAINT b_exp_cat_fk FOREIGN KEY ( budget )
        REFERENCES budgets ( b_id );

ALTER TABLE budgets
    ADD CONSTRAINT b_cat_b_fk FOREIGN KEY ( b_cat )
        REFERENCES budget_categories ( b_cat_id );

ALTER TABLE incomes
    ADD CONSTRAINT inc_cat_inc_fk FOREIGN KEY ( inc_cat )
        REFERENCES income_categories ( inc_cat_id );

ALTER TABLE expenses
    ADD CONSTRAINT exp_cat_exp_fk FOREIGN KEY ( exp_cat )
        REFERENCES expense_categories ( exp_cat_id );

ALTER TABLE incomes
    ADD CONSTRAINT acc_inc_fk FOREIGN KEY ( account )
        REFERENCES accounts ( acc_id );

ALTER TABLE accounts
    ADD CONSTRAINT acc_types_acc_fk FOREIGN KEY ( acc_type )
        REFERENCES account_types ( acc_type_id );

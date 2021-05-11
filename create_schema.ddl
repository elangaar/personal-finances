CREATE TABLE budgets (
    b_id             INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    amount           NUMBER(19, 4) NOT NULL,
    b_date           DATE NOT NULL,
    comments         VARCHAR2(255),
    b_cat       INTEGER NOT NULL
);

CREATE TABLE budget_categories (
    b_cat_id        INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    b_cat_name      VARCHAR2(30) NOT NULL
);

CREATE TABLE income_categories (
    inc_cat_id      INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    inc_cat_name    VARCHAR2(100) NOT NULL);

CREATE TABLE expense_categories (
    exp_cat_id      INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    exp_name        VARCHAR2(100) NOT NULL,
    budget          INTEGER NOT NULL
);

CREATE TABLE accounts (
    acc_id          INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    acc_name        VARCHAR2(30) NOT NULL,
    acc_type        INTEGER NOT NULL,
    currency        CHAR(3) NOT NULL,
    balance         NUMBER(19, 4) DEFAULT 0
);

CREATE TABLE incomes (
    inc_id          INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    amount          NUMBER(19, 4) NOT NULL,
    inc_date        DATE NOT NULL,
    comments        VARCHAR2(255),
    inc_cat         INTEGER NOT NULL,
    account         INTEGER NOT NULL
);

CREATE TABLE account_types (
    acc_type_id     INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    acc_type_name   VARCHAR2(50) NOT NULL
);

CREATE TABLE expenses (
    exp_id          INTEGER GENERATED BY DEFAULT AS IDENTITY START WITH 1 PRIMARY KEY,
    amount          NUMBER(19, 4) NOT NULL,
    exp_date        DATE NOT NULL,
    comments        VARCHAR2(255),
    exp_cat         INTEGER NOT NULL
);

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

CREATE OR REPLACE VIEW expenses_info AS 
SELECT
  ec.exp_name Expense_category,
  bc.b_cat_name Budget_category,
  a.acc_name Account_name,
  e.comments Comments,
  TO_CHAR(e.exp_date, 'DD-MM-YYYY') Expense_date,
  e.amount Expense_amount
FROM expenses e
  INNER JOIN expense_categories ec ON e.exp_cat = ec.exp_cat_id
  INNER JOIN budgets b ON ec.budget = b.b_id
  INNER JOIN budget_categories bc ON bc.b_cat_id = b.b_cat
  INNER JOIN accounts a ON ec.account = a.acc_id
ORDER BY
  Budget_category,
  Expense_category,
  Expense_amount DESC;


CREATE OR REPLACE VIEW month_budgets_info AS 
SELECT
  TO_CHAR(b.b_date, 'Mon YYYY') Budget_month,
  bc.b_cat_name Budget_category,
  b.amount Budget_amount
FROM budgets b INNER JOIN budget_categories bc ON bc.b_cat_id = b.b_cat
ORDER BY
  Budget_month,
  Budget_category;
  

CREATE OR REPLACE VIEW accounts_info AS 
SELECT
  a.acc_name Account_name,
  at.acc_type_name Account_type,
  a.currency Currency,
  a.opened Opened,
  a.closed Closed
FROM accounts a
  INNER JOIN account_types at ON a.acc_type = at.acc_type_id
ORDER BY
  Account_name;


CREATE OR REPLACE VIEW month_account_balances_info AS 
SELECT
  a.acc_name Account_name,
  at.acc_type_name Account_type,
  a.currency Currency,
  TO_CHAR(ab.acc_bal_date, 'MM-YYYY') Balance_date_num,
  MAX(TO_CHAR(ab.acc_bal_date, 'Mon YYYY')) Balance_date,
  MAX(ab.amount) keep (DENSE_RANK FIRST ORDER BY ab.acc_bal_date DESC) Account_balance
FROM accounts a
  INNER JOIN account_balances ab ON a.acc_id = ab.account
  INNER JOIN account_types at ON a.acc_type = at.acc_type_id
GROUP BY
  TO_CHAR(ab.acc_bal_date, 'Mon YYYY'),
  TO_CHAR(ab.acc_bal_date, 'MM-YYYY'),
  a.acc_name,
  a.currency,
  at.acc_type_name
ORDER BY
    TO_CHAR(ab.acc_bal_date, 'MM-YYYY');


CREATE OR REPLACE VIEW incomes_info AS 
SELECT
  i.inc_date Income_date,
  ic.inc_cat_name Income_category,
  i.amount Income_amount,
  i.comments Comments,
  a.acc_name Account_name
FROM incomes i
  INNER JOIN accounts a ON i.account = a.acc_id
  INNER JOIN income_categories ic ON i.income_category = ic.inc_cat_id
ORDER BY
  Income_date;



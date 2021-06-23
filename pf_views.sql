CREATE OR REPLACE VIEW expenses_info AS
SELECT ec.exp_name Expense_category
  , bc.b_cat_name Budget_category
  , a.acc_name Account_name
  , e.comments Comments
  , e.exp_date Expense_date
  , e.amount Expense_amount
FROM expenses e
  INNER JOIN expense_categories ec ON e.expense_category = ec.exp_cat_id
  INNER JOIN budgets b ON ec.budget = b.b_id
  INNER JOIN budget_categories bc ON bc.b_cat_id = b.budget_category
  INNER JOIN accounts a ON e.account = a.acc_id
ORDER BY Budget_category
  , Expense_category
  , Expense_amount DESC;


CREATE OR REPLACE VIEW month_budgets_info AS
SELECT b.b_date Budget_month
  , bc.b_cat_name Budget_category
  , b.amount Budget_amount
FROM budgets b INNER JOIN budget_categories bc ON bc.b_cat_id = b.budget_category
ORDER BY Budget_month
  , Budget_category;


CREATE OR REPLACE VIEW accounts_info AS
SELECT a.acc_name Account_name
  , at.acc_type_name Account_type
  , a.currency Currency
  , a.current_state Current_state
  , a.opened Opened
  , a.closed Closed
FROM accounts a
  INNER JOIN account_types at ON a.account_type = at.acc_type_id
ORDER BY
  Account_name;


CREATE OR REPLACE VIEW incomes_info AS
SELECT i.inc_date Income_date
  , ic.inc_cat_name Income_category
  , i.amount Income_amount
  , i.comments Comments
  , a.acc_name Account_name
FROM incomes i
  INNER JOIN accounts a ON i.account = a.acc_id
  INNER JOIN income_categories ic ON i.income_category = ic.inc_cat_id
ORDER BY
  Income_date;
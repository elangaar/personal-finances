create or replace trigger aiud_change_income_acc_balance
after insert or update or delete on incomes
for each row
begin
  if inserting then
    update accounts
    set balance = balance + :new.amount
    where acc_id = :new.account;
  elsif updating then
    if :new.account = :old.account then
      update accounts
      set balance = balance - (:old.amount - :new.amount)
      where acc_id = :new.account;
    else  
      update accounts
      set balance = balance - :new.amount
      where acc_id = :old.account;
      update accounts
      set balance = balance + :new.amount
      where acc_id = :new.account;
    end if;
  else
    update accounts
    set balance = balance - :old.amount
    where acc_id = :old.account;
  end if;
end;


create or replace trigger aiu_exp_budget
after insert or update on expenses
for each row
begin
  if inserting then
    merge into budgets
    using (
      select
        ec.budget ec_b -- need to use alias here...
      from
        expense_categories ec
      where
        ec.exp_cat_id = :new.exp_cat
    )
    on (budgets.b_id = ec_b) -- which will be used here
    when matched then
      update set budgets.amount = budgets.amount - :new.amount;
  elsif updating then
    merge into budgets
    using (
      select
        ec.budget ec_b -- need to use alias here...
      from
        expense_categories ec
      where
        ec.exp_cat_id = :new.exp_cat
    )
    on (budgets.b_id = ec_b) -- which will be used here
    when matched then
      update set budgets.amount = budgets.amount + (:old.amount - :new.amount);
  end if;
end;

create or replace trigger bd_exp_budget
before delete on expenses
for each row
begin
  merge into budgets
  using (
    select
      ec.budget ec_b
    from
      expense_categories ec
    where
      ec.exp_cat_id = :old.exp_cat
  )
  on (budgets.b_id = ec_b)
  when matched then
    update set budgets.amount = budgets.amount + :old.amount;
end;
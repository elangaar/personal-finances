-- trigger that changes amount account balance when income changes

create or replace trigger aiud_change_inc_acc_balance
after insert or update or delete on incomes
for each row
begin
  if inserting then
    insert into account_balances (acc_bal_date, amount, account)
    values (:new.inc_date, :new.amount, :new.amount);
  elsif updating then
    if :new.account = :old.account and :new.inc_date = :old.inc_date then
      update account_balances
      set amount = amount - (:old.amount - :new.amount)
      where account = :new.account
      and acc_bal_date = :new.inc_date;
    elsif :new.account != :old.account and :new.inc_date = :old.inc_date then
      update account_balances
      set amount = amount - :new.amount
      where account = :old.account
      and acc_bal_date = :new.inc_date;
      if --
      update account_balances
      set amount = amount + :new.amount
      where account = :new.account;
    end if;
  else
    update account_balances
    set amount = amount - :old.amount
    where account = :old.account;
  end if;
end;
/

-- trigger that changes budget when expense changes

create or replace trigger aiud_change_exp_change_budget
after insert or update or delete on expenses
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
    on (budgets.b_id = ec_b) -- ...which will be used here
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
    on (budgets.b_id = ec_b) -- ...which will be used here
    when matched then
      update set budgets.amount = budgets.amount + (:old.amount - :new.amount);
  end if;
end;
/

create or replace trigger biu_exp_date
before insert or update on expenses
for each row
begin
  if (:new.exp_date > SYSDATE) THEN
    RAISE_APPLICATION_ERROR (-20001,
      'Invalid date. Expense date must be <= ' || SYSDATE );
  END IF;
end;
/

create or replace trigger biu_acc_balances_date
before insert or update on account_balances
for each row
begin
  if (:new.acc_bal_date > SYSDATE) THEN
    RAISE_APPLICATION_ERROR (-20002,
      'Invalid date. Account balance date must be <= ' || SYSDATE );
  END IF;
end;
/

create or replace trigger biu_incomes_date
before insert or update on incomes
for each row
begin
  if (:new.inc_date > SYSDATE) THEN
    RAISE_APPLICATION_ERROR (-20003,
      'Invalid date. Income date must be <= ' || SYSDATE );
  END IF;
end;
/

create or replace trigger biu_accounts_opened
before insert or update on accounts
for each row
begin
  if (:new.opened > SYSDATE) then
    RAISE_APPLICATION_ERROR (-20003,
      'Invalid date. Opened date must be <= ' || SYSDATE );
  END IF;
END;
/

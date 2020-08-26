class RenameBalanceToInicialBalance < ActiveRecord::Migration[6.0]
  def change
    rename_column :accounts, :balance, :initial_balance
  end
end

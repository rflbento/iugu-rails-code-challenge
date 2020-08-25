class AddPrimaryKeyToAccounts < ActiveRecord::Migration[6.0]
  def change
    execute "ALTER TABLE accounts ADD PRIMARY KEY (id);"
  end
end

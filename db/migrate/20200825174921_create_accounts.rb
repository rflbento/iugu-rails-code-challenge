class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :account_number, null: false
      t.string :account_name, null: false
      t.integer :balance, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :accounts, :account_number, unique: true
    add_index :accounts, :token, unique: true
  end
end

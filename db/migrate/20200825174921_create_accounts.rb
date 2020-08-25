class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts, id: false do |t|
      t.integer :id, null: false
      t.string :name, null: false
      t.integer :balance, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :accounts, :id, unique: true
    add_index :accounts, :token, unique: true
  end
end

class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.integer :amount, null: false
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end

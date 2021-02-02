class CreateUserUsages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_usages do |t|
      t.string :path
      t.integer :number_of_clicks

      t.timestamps
    end
  end
end

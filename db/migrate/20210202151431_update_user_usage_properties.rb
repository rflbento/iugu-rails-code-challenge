class UpdateUserUsageProperties < ActiveRecord::Migration[6.0]
  def change
    change_column_null :user_usages, :path, false
    change_column_null :user_usages, :number_of_clicks, false
  end
end

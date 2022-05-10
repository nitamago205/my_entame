class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :rate, false
  end
end

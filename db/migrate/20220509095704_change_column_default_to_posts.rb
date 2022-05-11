class ChangeColumnDefaultToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_default :posts, :rate, from: nil, to: "0"
  end
end

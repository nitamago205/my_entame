class CreateMySelects < ActiveRecord::Migration[6.1]
  def change
    create_table :my_selects do |t|
      t.integer :post_id, null: false
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end

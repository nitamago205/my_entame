class CreateGanres < ActiveRecord::Migration[6.1]
  def change
    create_table :ganres do |t|
      t.string :ganre_name, null: false

      t.timestamps
    end
  end
end

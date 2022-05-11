class ChangeGanresToGenres < ActiveRecord::Migration[6.1]
  def change
    rename_table :ganres, :genres
  end
end

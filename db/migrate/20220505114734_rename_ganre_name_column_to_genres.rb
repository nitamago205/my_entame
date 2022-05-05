class RenameGanreNameColumnToGenres < ActiveRecord::Migration[6.1]
  def change
    rename_column :genres, :ganre_name, :genre_name
  end
end

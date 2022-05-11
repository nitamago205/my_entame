class RenameGanreIdColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :ganre_id, :genre_id
  end
end

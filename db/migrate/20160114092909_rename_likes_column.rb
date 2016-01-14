class RenameLikesColumn < ActiveRecord::Migration
  def change
    rename_column :likes, :likes, :like
  end
end

class AddFavoritesCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :favorites_count, :intenger
  end
end

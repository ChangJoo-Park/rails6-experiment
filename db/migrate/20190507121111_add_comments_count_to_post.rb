class AddCommentsCountToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :comments_count, :integer
  end
end

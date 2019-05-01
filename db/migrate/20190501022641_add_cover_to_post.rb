class AddCoverToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :cover, :string
  end
end

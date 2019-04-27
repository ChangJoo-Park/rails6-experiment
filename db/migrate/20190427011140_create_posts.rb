class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.boolean :published
      t.datetime :published_at
      t.string :slug

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end

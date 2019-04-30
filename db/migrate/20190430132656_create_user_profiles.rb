class CreateUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_profiles do |t|
      t.string :bio
      t.string :avatar
      t.string :username
      t.string :name
      t.string :website
      t.string :background_color
      t.string :foreground_color
      t.string :location
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_profiles, :username, unique: true
  end
end

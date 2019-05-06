class AddUsernameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    # add_index :user_profiles, :username, unique: true
    remove_column :user_profiles, :username, :string
  end
end

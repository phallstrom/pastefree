class RemoveUserFields < ActiveRecord::Migration
  def self.up
    remove_column :pastes, :user_id
    drop_table :users
  end

  def self.down
    add_column :pastes, :user_id, :integer
    CreateUsers.up
  end
end

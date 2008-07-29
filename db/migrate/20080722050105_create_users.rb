class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :token, :length => 40
      t.integer :paste_count, :default => 0
      t.boolean :is_confirmed, :default => false

      t.timestamps
    end
    add_index :users, :email, :unique => true
    add_index :users, :token

  end

  def self.down
    drop_table :users
  end
end

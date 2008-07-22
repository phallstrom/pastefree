class CreatePastes < ActiveRecord::Migration
  def self.up
    create_table :pastes do |t|
      t.integer :user_id
      t.text :content
      t.string :theme, :length => 32
      t.string :syntax, :length => 32
      t.string :file_path
      t.string :file_type, :length => 64
      t.boolean :is_private, :default => false
      t.string :user_ip, :length => 15
      t.string :user_agent

      t.timestamps
    end

    add_index :pastes, :user_id
  end

  def self.down
    drop_table :pastes
  end
end

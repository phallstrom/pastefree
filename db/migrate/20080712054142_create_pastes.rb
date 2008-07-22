class CreatePastes < ActiveRecord::Migration
  def self.up
    create_table :pastes do |t|
      t.integer :user_id
      t.integer :theme_id
      t.integer :syntax_id
      t.text :content
      t.string :theme, :length => 32
      t.string :syntax, :length => 32
      t.string :file_path
      t.string :file_type, :length => 64
      t.boolean :is_private, :default => false
      t.boolean :is_approved, :default => false

      t.timestamps
    end

    add_index :pastes, :user_id
  end

  def self.down
    drop_table :pastes
  end
end

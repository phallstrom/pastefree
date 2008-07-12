class CreatePastes < ActiveRecord::Migration
  def self.up
    create_table :pastes do |t|
      t.text :content
      t.string :theme
      t.string :syntax
      t.string :file_path
      t.string :file_type
      t.boolean :is_private
      t.string :user_ip
      t.string :user_agent

      t.timestamps
    end
  end

  def self.down
    drop_table :pastes
  end
end

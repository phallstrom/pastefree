class AddPaperclip < ActiveRecord::Migration
  def self.up
    remove_column :pastes, :file_path
    remove_column :pastes, :file_type
    add_column :pastes, :image_file_name,    :string
    add_column :pastes, :image_content_type, :string
    add_column :pastes, :image_file_size,    :integer
    add_column :pastes, :image_updated_at,   :datetime
  end

  def self.down
    remove_column :pastes, :image_file_name
    remove_column :pastes, :image_content_type
    remove_column :pastes, :image_file_size
    remove_column :pastes, :image_updated_at
    add_column :pastes, :file_path, :string
    add_column :pastes, :file_type, :string
  end
end

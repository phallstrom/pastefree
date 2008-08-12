class RemoveThemePasteCount < ActiveRecord::Migration
  def self.up
    remove_column :themes, :paste_count
  end

  def self.down
    add_column :themes, :paste_count, :integer
  end
end

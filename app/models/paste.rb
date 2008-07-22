class Paste < ActiveRecord::Base

  validates_presence_of :file_type, :unless => Proc.new {|p| p.file_path.blank?}

  belongs_to :user
  belongs_to :syntax
  belongs_to :theme

  named_scope :approved, :conditions => {:is_approved => true}

  # 
  # Increment the paste counts every time we save a paste.
  #
  def after_save
    user.increment!(:paste_count) unless user.nil?
    syntax.increment!(:paste_count) unless syntax.nil?
    theme.increment!(:paste_count) unless theme.nil?
  end

end

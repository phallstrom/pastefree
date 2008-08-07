require 'uv'

class Paste < ActiveRecord::Base

  belongs_to :user
  belongs_to :syntax
  belongs_to :theme

  validates_presence_of :content
  validates_presence_of :file_type, :unless => Proc.new {|p| p.file_path.blank?}

  named_scope :approved, :conditions => {:is_approved => true}, :order => 'created_at DESC'

  #
  # Set a default theme and syntax if none are specified.
  #
  def before_save
    self.theme = Theme.find_by_code('idle') if theme.nil?
    self.syntax = Syntax.find_by_code('plain_text') if syntax.nil?
  end

  # 
  # Increment the paste counts every time we save a paste.
  #
  def after_save
    user.increment!(:paste_count) unless user.nil?
    syntax.increment!(:paste_count)
    theme.increment!(:paste_count)
  end

  #
  #
  #
  def highlighted_content
    Uv.parse( content, "xhtml", syntax.code, true, theme.code)
  end

end

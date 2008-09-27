require 'uv'

class Paste < ActiveRecord::Base

  belongs_to :syntax
  belongs_to :theme

  validates_presence_of :content
  validates_length_of :content, :maximum => 10_000
  validates_presence_of :file_type, :unless => Proc.new {|p| p.file_path.blank?}


  named_scope :recent, :conditions => {:is_approved => true}, :order => 'created_at DESC', :limit => 3
  named_scope :approved, :conditions => {:is_approved => true}, :order => 'created_at DESC'

  #
  # Set a default theme and syntax if none are specified.
  #
  def before_save
    self.theme = Theme.find_by_code('idle') if theme.nil?
    self.syntax = Syntax.find_by_code('plain_text') if syntax.nil?
  end

  # 
  # Increment the paste counts every time we create a paste.
  #
  def after_create
    syntax.increment!(:paste_count)
  end

  #
  #
  #
  def highlighted_content
    Uv.parse( content, "xhtml", syntax.code, true, theme.code)
  end

  #
  #
  #
  def snippet
    snippet = content.split("\n").slice(0,3).join("\n")
    if snippet.length > 255
      snippet[0,255] + "..."
    else
      snippet
    end
  end
end

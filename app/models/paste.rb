class Paste < ActiveRecord::Base

  validates_presence_of :file_type, :unless => Proc.new {|p| p.file_path.blank?}
  validates_presence_of :user_ip
  validates_format_of :user_ip, :with => /\A\d{0,3}\.\d{0,3}\.\d{0,3}\.\d{0,3}\Z/
  validates_presence_of :user_agent

  belongs_to :user
  belongs_to :syntax
  belongs_to :theme

  # 
  # Increment the paste counts every time we save a paste.
  #
  def after_save
    user.increment!(:paste_count) unless user.nil?
    syntax.increment!(:paste_count) unless syntax.nil?
    theme.increment!(:paste_count) unless theme.nil?
  end

end

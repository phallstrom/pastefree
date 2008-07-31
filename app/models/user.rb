require 'digest/sha1'

class User < ActiveRecord::Base

  has_many :pastes, :order => 'created_at DESC'
  has_many :approved_pastes, :class_name => 'Paste', :conditions => {:is_approved => true}, :order => 'created_at DESC'
  has_many :unapproved_pastes, :class_name => 'Paste', :conditions => {:is_approved => false}, :order => 'created_at DESC'

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_email_format_of :email, :allow_blank => true

  #
  #
  #
  def before_validation
    self.email = email.strip.downcase unless email.blank?
  end

  #
  #
  #
  def before_save
    self.token = self.class.generate_token(email)
  end

  #
  #
  #
  def self.generate_token(email)
    Digest::SHA1.hexdigest("Sam-and-Tom-#{email}")
  end

  #
  #
  #
  def generate_token
    self.class.generate_token(email)
  end


end

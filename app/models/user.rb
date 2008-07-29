require 'digest/sha1'

class User < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :pastes, :order => 'created_at DESC'
  has_many :approved_pastes, :class_name => 'Paste', :conditions => {:is_approved => true}, :order => 'created_at DESC'
  has_many :unapproved_pastes, :class_name => 'Paste', :conditions => {:is_approved => false}, :order => 'created_at DESC'

  #
  #
  #
  def before_save
    self.email = self.email.strip.downcase
    self.token = self.class.generate_token(self.email)
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

require 'digest/sha1'

class User < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email

  validates_presence_of :token

  has_many :pastes, :order => 'created_at DESC'
end

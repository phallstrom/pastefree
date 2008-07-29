require 'digest/sha1'

class User < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :pastes, :order => 'created_at DESC'

  def before_save
    self.token = make_token(self.email)
  end

  private ############################################################

  def make_token(str)
    Digest::SHA1.hexdigest("SAM-AND-TOM-#{str}-#{Time.now}")
  end


end

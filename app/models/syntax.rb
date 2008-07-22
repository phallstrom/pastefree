class Syntax < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :code
  validates_uniqueness_of :code

  has_many :pastes


  def self.options_for_select
    find(:all, :order => 'name').map {|e| [e.name, e.id]}
  end

end

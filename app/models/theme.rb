class Theme < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :code
  validates_uniqueness_of :code

  has_many :pastes

  def self.options_for_select(name = :name, id = :id)
    [['Theme', '']] + find(:all, :order => 'name').map {|e| [e.send(name), e.send(id)]}
  end

end

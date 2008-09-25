class Syntax < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_presence_of :code
  validates_uniqueness_of :code

  has_many :pastes

  def self.options_for_select
    [['Syntax', '']] + find(:all, :order => 'name').map {|e| [e.name, e.id]}
  end

  def self.data_for_chart(popular = 10)
    labels = []
    counts = []
    find(:all, :conditions => 'paste_count > 0', :order => 'paste_count DESC, name').each_with_index do |s, i|
      labels[[i,popular].min] = s.name
      counts[[i,popular].min] ||= 0
      counts[[i,popular].min] += s.paste_count
    end

    labels[popular] = 'Other'

    (0..popular).map {|i| counts[i].to_i > 0 ? "{ data: [[0, #{counts[i].to_i}]], label: '#{labels[i]}'}" : nil }.compact.join(',')
  end

end

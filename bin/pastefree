#!/usr/bin/ruby

%w( rubygems activeresource ).each do |dep|
  begin
    require dep
  rescue LoadError
    abort "#{dep} is required for pastefree to run."
  end
end

class Paste < ActiveResource::Base
  self.site = ARGV.delete('-d').nil? ? 'http://pastefree.pjkh.com' : 'http://localhost:3000'

  def full_url
    "#{self.class.site}pastes/#{id}"
  end
end

pf = Paste.new(:content => STDIN.read, :syntax => ARGV.shift)
if pf.save
  puts pf.full_url
  exit 0
else
  puts "Errors: " + pf.errors.full_messages.join(". ")
  exit 1
end


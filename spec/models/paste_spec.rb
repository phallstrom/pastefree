require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Paste do
  before(:each) do
    @paste = Paste.new(:user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
  end

  it "should be valid" do
    @paste.should be_valid
  end

  it "should require a user ip" do
    @paste.user_ip = nil
    @paste.should_not be_valid
    @paste.should have(2).errors_on(:user_ip)
  end

  it "should accept all valid ip addresses" do
    %w[1 12 123].each do |a|
      %w[1 12 123].each do |b|
        %w[1 12 123].each do |c|
          %w[1 12 123].each do |d|
            @paste.user_ip = "#{a}.#{b}.#{c}.#{d}"
            @paste.should be_valid
          end
        end
      end
    end
  end

  it "should require a user agent" do
    @paste.user_agent = nil
    @paste.should_not be_valid
    @paste.should have(1).error_on(:user_agent)
  end


  it "should have a valid theme if specified" do
    @paste.theme = 'invalid!!!'
    @paste.should_not be_valid
    @paste.should have(1).error_on(:theme)
  end

  it "should be valid if valid theme is specified" do
    @paste.theme = 'zenburnesque'
    @paste.should be_valid
  end

  it "should have a valid syntax if specified" do
    @paste.syntax = 'invalid!!!'
    @paste.should_not be_valid
    @paste.should have(1).error_on(:syntax)
  end

  it "should be valid if valid syntax is specified" do
    @paste.syntax = 'ruby'
    @paste.should be_valid
  end

  it "should have a file type if it has a file path" do
    @paste.file_path = '/tmp/file'
    @paste.should_not be_valid
    @paste.should have(1).error_on(:file_type)
  end

  it "should be valid if both a file type and file path are specified" do 
    @paste.file_path = '/tmp/file'
    @paste.file_type = 'mime/type'
    @paste.should be_valid
  end

end

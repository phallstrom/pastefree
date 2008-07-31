require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Paste do
  before(:each) do
    @paste = Paste.new(:content => 'foo bar')
  end

  it "should be valid" do
    @paste.should be_valid
  end

  it "should require some content" do
    @paste.content = nil
    @paste.should_not be_valid
    @paste.should have(1).error_on(:content)
  end

  it "should set a default syntax" do
    @paste.save
    @paste.reload
    @paste.syntax.should_not be_nil
  end

  it "should set a default theme" do
    @paste.save
    @paste.reload
    @paste.theme.should_not be_nil
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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Paste do
  before(:each) do
    @paste = Paste.new(:content => 'foo bar')
  end

  it "should be valid" do
    @paste.should be_valid
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

end

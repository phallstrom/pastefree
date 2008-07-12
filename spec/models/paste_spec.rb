require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Paste do
  before(:each) do
    @paste = Paste.new
  end

  it "should be valid" do
    @paste.should be_valid
  end
end

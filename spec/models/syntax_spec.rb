require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Syntax do
  before(:each) do
    @syntax = Syntax.new(:name => 'Foo', :code => 'foo')
  end

  it "should be valid" do
    @syntax.should be_valid
  end

  it "should require a name" do
    @syntax.name = nil
    @syntax.should_not be_valid
    @syntax.should have(1).error_on(:name)
  end

  it "should have a unique name" do
    @syntax.name = 'Foo'
    @syntax.code = 'foo'
    @syntax.save

    lambda {
      Syntax.new(@syntax.attributes).save
    }.should_not change(Syntax, :count)

    lambda {
      Syntax.new(@syntax.attributes.with(:name => 'Bar', :code => 'bar')).save
    }.should change(Syntax, :count).by(1)
  end

  it "should require a code" do
    @syntax.code = nil
    @syntax.should_not be_valid
    @syntax.should have(1).error_on(:code)
  end

  it "should have a unique code" do
    @syntax.name = 'Foo'
    @syntax.code = 'foo'
    @syntax.save

    lambda {
      Syntax.new(@syntax.attributes).save
    }.should_not change(Syntax, :count)

    lambda {
      Syntax.new(@syntax.attributes.with(:name => 'Bar', :code => 'bar')).save
    }.should change(Syntax, :count).by(1)
  end

  it "should increment the paste_count" do
    @syntax.save

    Paste.create(:syntax => @syntax, :content => 'Testing 1', :user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
    Paste.count.should == 1
    @syntax.reload
    @syntax.paste_count.should == 1

    Paste.create(:syntax => @syntax, :content => 'Testing 2', :user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
    Paste.count.should == 2
    @syntax.reload
    @syntax.paste_count.should == 2

    # paste count never decrements, it's like an odometer
    Paste.last.destroy
    Paste.count.should == 1
    @syntax.reload
    @syntax.paste_count.should == 2
  end
end

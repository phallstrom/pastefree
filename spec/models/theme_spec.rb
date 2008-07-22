require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Theme do
  before(:each) do
    @theme = Theme.new(:name => 'Foo', :code => 'foo')
  end

  it "should be valid" do
    @theme.should be_valid
  end

  it "should require a name" do
    @theme.name = nil
    @theme.should_not be_valid
    @theme.should have(1).error_on(:name)
  end

  it "should have a unique name" do
    @theme.name = 'Foo'
    @theme.code = 'foo'
    @theme.save

    lambda {
      Theme.new(@theme.attributes).save
    }.should_not change(Theme, :count)

    lambda {
      Theme.new(@theme.attributes.with(:name => 'Bar', :code => 'bar')).save
    }.should change(Theme, :count).by(1)
  end

  it "should require a code" do
    @theme.code = nil
    @theme.should_not be_valid
    @theme.should have(1).error_on(:code)
  end

  it "should have a unique code" do
    @theme.name = 'Foo'
    @theme.code = 'foo'
    @theme.save

    lambda {
      Theme.new(@theme.attributes).save
    }.should_not change(Theme, :count)

    lambda {
      Theme.new(@theme.attributes.with(:name => 'Bar', :code => 'bar')).save
    }.should change(Theme, :count).by(1)
  end

  it "should increment the paste_count" do
    @theme.save

    Paste.create(:theme => @theme, :content => 'Testing 1', :user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
    Paste.count.should == 1
    @theme.reload
    @theme.paste_count.should == 1

    Paste.create(:theme => @theme, :content => 'Testing 2', :user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
    Paste.count.should == 2
    @theme.reload
    @theme.paste_count.should == 2

    # paste count never decrements, it's like an odometer
    Paste.last.destroy
    Paste.count.should == 1
    @theme.reload
    @theme.paste_count.should == 2
  end
end

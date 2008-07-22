require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = User.new(:email => 'philip@pjkh.com', :token => 'b5776bafff6a5f4bf54e5c408c701cd5da7f475a')
  end

  it "should be valid" do
    @user.should be_valid
  end

  it "should require an email" do
    @user.email = nil
    @user.should_not be_valid
    @user.should have(1).error_on(:email)
  end

  it "should have a unique email" do
    @user.email = 'philip@pjkh.com'
    @user.save

    lambda {
      User.new(@user.attributes).save
    }.should_not change(User, :count)

    lambda {
      User.new(@user.attributes.with(:email => 'nobody@pjkh.com')).save
    }.should change(User, :count).by(1)
  end

  it "should have a token" do
    @user.token = nil
    @user.should_not be_valid
  end

  it "should increment the paste_count" do
    @user.save

    @user.pastes.create(:content => 'Testing 1', :user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
    Paste.count.should == 1
    @user.reload
    @user.paste_count.should == 1

    @user.pastes.create(:content => 'Testing 2', :user_ip => '127.0.0.1', :user_agent => 'RSpec Browser')
    Paste.count.should == 2
    @user.reload
    @user.paste_count.should == 2

    # paste count never decrements, it's like an odometer
    @user.pastes.last.destroy
    Paste.count.should == 1
    @user.reload
    @user.paste_count.should == 2
  end

end
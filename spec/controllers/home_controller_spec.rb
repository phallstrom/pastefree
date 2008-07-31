require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
  describe "handling user confirmation" do

    it "should set a cookie on valid confirmation" do
      @user = mock_model(User, :to_param => "1", :email => 'philip@pjkh.com', :token => 'token_for_philip', :generate_token => 'token_for_philip')
      User.stub!(:generate_token).and_return(@user.token)
      User.stub!(:find_by_token).with(@user.token).and_return(@user)

      @user.should_receive(:update_attribute).with(:is_confirmed, true)
      @user.should_receive(:unapproved_pastes).and_return([])
      @user.should_receive(:pastes).and_return([1])

      get :confirm_user, :token => @user.token
      cookies['token'].value.should == [@user.token]

    end

  end
end

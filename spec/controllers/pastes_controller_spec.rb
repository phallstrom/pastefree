require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PastesController do
  
  #
  #
  #
  describe "handling GET /pastes" do

    before(:each) do
      @paste = mock_model(Paste)
    end
  
    def do_get
      get :index
    end

    it "should redirect to new paste form" do
      do_get
      response.should redirect_to(new_paste_url)
    end
  
  end

  
  #
  #
  #
  describe "handling GET /pastes.xml" do

    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end

    it "should return status 405" do
      do_get
      response.should_not be_success
      response.headers['Status'].should == "405 Method Not Allowed"
    end

  end
  
 
  
  #
  #
  #
  describe "handling GET /pastes/1" do

    before(:each) do
      @paste = mock_model(Paste)
      Paste.stub!(:find).and_return(@paste)
      @paste.stub!(:is_approved?).and_return(true)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template if approved" do
      do_get
      @paste.stub!(:is_approved?).and_return(true)
      response.should render_template('show')
    end
  
    it "should render show_pending template if not approved" do
      @paste.stub!(:is_approved?).and_return(false)
      do_get
      response.should render_template('show_pending')
    end

    it "should find the paste requested" do
      Paste.should_receive(:find).with("1").and_return(@paste)
      do_get
    end
  
    it "should assign the found paste for the view" do
      do_get
      assigns[:paste].should equal(@paste)
    end
  end


  
  #
  #
  #
  describe "handling GET /pastes/1.xml" do

    before(:each) do
      @paste = mock_model(Paste)
      Paste.stub!(:find).and_return(@paste)
      @paste.stub!(:is_approved?).and_return(true)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should return 405 method not allowed" do
      do_get
      response.should_not be_success
      response.headers['Status'].should == "405 Method Not Allowed"
    end

    it "should find the paste requested" do
      Paste.should_receive(:find).with("1").and_return(@paste)
      do_get
    end
  
    it "should assign the found paste for the view" do
      do_get
      assigns[:paste].should equal(@paste)
    end
  end


  #
  #
  #
  describe "handling GET /pastes/new" do

    before(:each) do
      @paste = mock_model(Paste)
      @user = mock_model(User)
      Paste.stub!(:new).and_return(@paste)
      Paste.stub!(:find_by_token).and_return(@user)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create a new paste" do
      Paste.should_receive(:new).and_return(@paste)
      do_get
    end
  
    it "should not save the new paste" do
      @paste.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new paste for the view" do
      do_get
      assigns[:paste].should equal(@paste)
    end

  end

  
  #
  #
  #
  describe "handling GET /pastes/1/edit" do

    def do_get
      get :edit, :id => "1"
    end

    it "should be return 405 method not allowed" do
      do_get
      response.should_not be_success
      response.headers['Status'].should == "405 Method Not Allowed"
    end

  end

  #
  #
  #
  describe "handling POST /pastes" do

    before(:each) do
      @paste = mock_model(Paste, :to_param => "1", :content => 'Content 1')
      @user = mock_model(User, :to_param => "1", :email => 'philip@pjkh.com', :token => 'token_for_philip', :generate_token => 'token_for_philip')
      Paste.stub!(:new).and_return(@paste)
      User.stub!(:find_by_token).with(@user.token).and_return(@user)
    end
    
    def do_post(params)
      post :create, params
    end

    it "should fail on an empty paste" do
      params = {:paste => {'content' => ''}, :email => @user.email, :token => @user.token}
      Paste.should_receive(:new).with(params[:paste]).and_return(@paste)
      @paste.should_receive(:valid?).and_return(false)
      @paste.errors.should_receive(:full_messages)
      do_post params
      response.should render_template('new')
      assigns[:errors].should_not be_empty
    end

    it "should fail on a missing email address" do
      params = {:paste => {'content' => 'foo bar'}, :email => '', :token => ''}
      Paste.should_receive(:new).with(params[:paste]).and_return(@paste)
      @paste.should_receive(:valid?).and_return(true)
      do_post params
      response.should render_template('new')
      assigns[:errors].should_not be_empty
    end

    it "should fail on a bogus email address" do
      params = {:paste => {'content' => 'foo bar'}, :email => 'bogus', :token => ''}
      Paste.should_receive(:new).with(params[:paste]).and_return(@paste)
      @paste.should_receive(:valid?).and_return(true)
      do_post params
      response.should render_template('new')
      assigns[:errors].should_not be_empty
    end

    it "should create a new paste w/ a user" do
      params = {:paste => {'content' => 'foo bar'}, :token => 'token_for_philip'}
      @user.stub!(:is_confirmed?).and_return(true)

      Paste.should_receive(:new).with(params[:paste]).and_return(@paste)

      User.should_receive(:find_by_token).with(nil).and_return(nil)
      User.should_receive(:find_by_token).with(@user.token).and_return(@user)
      
      User.should_not_receive(:find_or_create_by_email).with(@user.email)
      @paste.should_receive(:valid?).and_return(true)
      @paste.should_receive(:is_approved=).with(true)
      @paste.should_receive(:user=).with(@user)
      @paste.should_receive(:save).and_return(true)

      do_post params
      response.should redirect_to(paste_url("1"))
    end

    it "should create a new paste w/o a user" do
      params = {:paste => {'content' => 'foo bar'}, :email => 'philip@pjkh.com'}
      @user.stub!(:is_confirmed?).and_return(false)

      Paste.should_receive(:new).with(params[:paste]).and_return(@paste)
      User.should_receive(:find_or_create_by_email).with(@user.email).and_return(@user)
      @user.should_receive(:valid?).and_return(true)
      @user.should_receive(:update_attribute).with(:is_confirmed, false)
      @paste.should_receive(:valid?).and_return(true)
      @paste.should_receive(:is_approved=).with(false)
      @paste.should_receive(:user=).with(@user)
      @paste.should_receive(:save).and_return(true)
      Mailer.should_receive(:deliver_user_confirmation)

      do_post params
      response.should redirect_to(paste_url("1"))
    end

  end
  
  
  #
  #
  #
  describe "handling PUT /pastes/1" do

    def do_put
      put :update, :id => "1"
    end

    it "should be return 405 method not allowed" do
      do_put
      response.should_not be_success
      response.headers['Status'].should == "405 Method Not Allowed"
    end

  end


  
  #
  #
  #
  describe "handling DELETE /pastes/1" do

    def do_delete
      delete :destroy, :id => "1"
    end

    it "should be return 405 method not allowed" do
      do_delete
      response.should_not be_success
      response.headers['Status'].should == "405 Method Not Allowed"
    end

  end

end

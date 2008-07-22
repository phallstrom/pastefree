require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PastesController do
  describe "handling GET /pastes" do

    before(:each) do
      @paste = mock_model(Paste)
      Paste.stub!(:find).and_return([@paste])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all pastes" do
      Paste.should_receive(:find).with(:all).and_return([@paste])
      do_get
    end
  
    it "should assign the found pastes for the view" do
      do_get
      assigns[:pastes].should == [@paste]
    end
  end

  describe "handling GET /pastes.xml" do

    before(:each) do
      @pastes = mock("Array of Pastes", :to_xml => "XML")
      Paste.stub!(:find).and_return(@pastes)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all pastes" do
      Paste.should_receive(:find).with(:all).and_return(@pastes)
      do_get
    end
  
    it "should render the found pastes as xml" do
      @pastes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /pastes/1" do

    before(:each) do
      @paste = mock_model(Paste)
      Paste.stub!(:find).and_return(@paste)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
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

  describe "handling GET /pastes/1.xml" do

    before(:each) do
      @paste = mock_model(Paste, :to_xml => "XML")
      Paste.stub!(:find).and_return(@paste)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the paste requested" do
      Paste.should_receive(:find).with("1").and_return(@paste)
      do_get
    end
  
    it "should render the found paste as xml" do
      @paste.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /pastes/new" do

    before(:each) do
      @paste = mock_model(Paste)
      Paste.stub!(:new).and_return(@paste)
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
  
    it "should create an new paste" do
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

  describe "handling GET /pastes/1/edit" do

    before(:each) do
      @paste = mock_model(Paste)
      Paste.stub!(:find).and_return(@paste)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the paste requested" do
      Paste.should_receive(:find).and_return(@paste)
      do_get
    end
  
    it "should assign the found Paste for the view" do
      do_get
      assigns[:paste].should equal(@paste)
    end
  end

  describe "handling POST /pastes" do

    before(:each) do
      @paste = mock_model(Paste, :to_param => "1", :content => 'Content 1')
      Paste.stub!(:new).and_return(@paste)
    end
    
    describe "with successful save" do
  
      def do_post
        @paste.should_receive(:save).and_return(true)
        post :create, :paste => {}
      end
  
      it "should create a new paste" do
        Paste.should_receive(:new).with({}).and_return(@paste)
        do_post
      end

      it "should redirect to the new paste" do
        do_post
        response.should redirect_to(paste_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @paste.should_receive(:save).and_return(false)
        post :create, :paste => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /pastes/1" do

    before(:each) do
      @paste = mock_model(Paste, :to_param => "1")
      Paste.stub!(:find).and_return(@paste)
    end
    
    describe "with successful update" do

      def do_put
        @paste.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the paste requested" do
        Paste.should_receive(:find).with("1").and_return(@paste)
        do_put
      end

      it "should update the found paste" do
        do_put
        assigns(:paste).should equal(@paste)
      end

      it "should assign the found paste for the view" do
        do_put
        assigns(:paste).should equal(@paste)
      end

      it "should redirect to the paste" do
        do_put
        response.should redirect_to(paste_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @paste.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /pastes/1" do

    before(:each) do
      @paste = mock_model(Paste, :destroy => true)
      Paste.stub!(:find).and_return(@paste)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the paste requested" do
      Paste.should_receive(:find).with("1").and_return(@paste)
      do_delete
    end
  
    it "should call destroy on the found paste" do
      @paste.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the pastes list" do
      do_delete
      response.should redirect_to(pastes_url)
    end
  end
end

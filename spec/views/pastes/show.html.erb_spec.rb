require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/show.html.erb" do
  include PastesHelper
  
  before(:each) do
    @paste = mock_model(Paste)
    @paste.stub!(:content).and_return("MyText")
    @paste.stub!(:theme).and_return("MyString")
    @paste.stub!(:syntax).and_return("MyString")
    @paste.stub!(:file_path).and_return("MyString")
    @paste.stub!(:file_type).and_return("MyString")
    @paste.stub!(:is_private).and_return(false)
    @paste.stub!(:user_ip).and_return("MyString")
    @paste.stub!(:user_agent).and_return("MyString")

    assigns[:paste] = @paste
  end

  it "should render attributes in <p>" do
    render "/pastes/show.html.erb"
    response.should have_text(/MyText/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end


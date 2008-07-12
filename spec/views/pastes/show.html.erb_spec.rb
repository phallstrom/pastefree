require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/show.html.erb" do
  include PastesHelper
  
  before(:each) do
    @paste = mock_model(Paste)
    @paste.stub!(:content).and_return("MyContent")
    @paste.stub!(:theme).and_return("MyTheme")
    @paste.stub!(:syntax).and_return("MySyntax")
    @paste.stub!(:file_path).and_return("MyFilePath")
    @paste.stub!(:file_type).and_return("MyFileType")
    @paste.stub!(:is_private).and_return(false)
    @paste.stub!(:user_ip).and_return("MyUserIp")
    @paste.stub!(:user_agent).and_return("MyUserAgent")

    assigns[:paste] = @paste
  end

  it "should render attributes in <p>" do
    render "/pastes/show.html.erb"
    response.should have_text(/MyContent/)
    response.should have_text(/MyTheme/)
    response.should have_text(/MySyntax/)
    response.should have_text(/MyFilePath/)
    response.should_not have_text(/MyFileType/)
    response.should have_text(/als/)
    response.should_not have_text(/MyUserIp/)
    response.should_not have_text(/MyUserAgent/)
  end
end


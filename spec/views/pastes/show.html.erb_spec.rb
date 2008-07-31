require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/show.html.erb" do
  include PastesHelper
  
  before(:each) do
    @paste = mock_model(Paste)
    @paste.stub!(:content).and_return("MyContent")

    @theme = mock_model(Theme)
    @theme.stub!(:name).and_return("MyTheme")
    @paste.stub!(:theme).and_return(@theme)

    @syntax = mock_model(Syntax)
    @syntax.stub!(:name).and_return("MySyntax")
    @paste.stub!(:syntax).and_return(@syntax)

    @paste.stub!(:file_path).and_return("MyFilePath")
    @paste.stub!(:file_type).and_return("MyFileType")
    @paste.stub!(:user_ip).and_return("MyUserIp")
    @paste.stub!(:user_agent).and_return("MyUserAgent")

    assigns[:paste] = @paste
  end

  it "should render attributes in <p>" do
    render "/pastes/show.html.erb"
    response.should have_text(/MyContent/)
  end
end


require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/index.html.erb" do
  include PastesHelper
  
  before(:each) do
    paste_98 = mock_model(Paste)
    paste_98.should_receive(:content).and_return("MyContent")
    paste_98.should_receive(:theme).and_return("MyTheme")
    paste_98.should_receive(:syntax).and_return("MySyntax")
    paste_98.should_receive(:file_path).and_return("MyFilePath")
    paste_98.should_receive(:file_type).and_return("MyFileType")
    paste_98.should_receive(:is_private).and_return(false)
    paste_98.should_not_receive(:user_ip)
    paste_98.should_not_receive(:user_agent)

    paste_99 = mock_model(Paste)
    paste_99.should_receive(:content).and_return("MyContent")
    paste_99.should_receive(:theme).and_return("MyTheme")
    paste_99.should_receive(:syntax).and_return("MySyntax")
    paste_99.should_receive(:file_path).and_return("MyFilePath")
    paste_99.should_receive(:file_type).and_return("MyFileType")
    paste_99.should_receive(:is_private).and_return(false)
    paste_99.should_not_receive(:user_ip)
    paste_99.should_not_receive(:user_agent)

    assigns[:pastes] = [paste_98, paste_99]
  end

  it "should render list of pastes" do
    render "/pastes/index.html.erb"
    response.should have_tag("tr>td", "MyContent", 2)
    response.should have_tag("tr>td", "MyTheme", 2)
    response.should have_tag("tr>td", "MySyntax", 2)
    response.should have_tag("tr>td", "MyFilePath", 2)
    response.should have_tag("tr>td", "MyFileType", 2)
    response.should have_tag("tr>td", "false", 2)
  end
end


require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/index.html.erb" do
  include PastesHelper
  
  before(:each) do
    paste_98 = mock_model(Paste)
    paste_98.should_receive(:content).and_return("MyText")
    paste_98.should_receive(:theme).and_return("MyString")
    paste_98.should_receive(:syntax).and_return("MyString")
    paste_98.should_receive(:file_path).and_return("MyString")
    paste_98.should_receive(:file_type).and_return("MyString")
    paste_98.should_receive(:is_private).and_return(false)
    paste_98.should_receive(:user_ip).and_return("MyString")
    paste_98.should_receive(:user_agent).and_return("MyString")
    paste_99 = mock_model(Paste)
    paste_99.should_receive(:content).and_return("MyText")
    paste_99.should_receive(:theme).and_return("MyString")
    paste_99.should_receive(:syntax).and_return("MyString")
    paste_99.should_receive(:file_path).and_return("MyString")
    paste_99.should_receive(:file_type).and_return("MyString")
    paste_99.should_receive(:is_private).and_return(false)
    paste_99.should_receive(:user_ip).and_return("MyString")
    paste_99.should_receive(:user_agent).and_return("MyString")

    assigns[:pastes] = [paste_98, paste_99]
  end

  it "should render list of pastes" do
    render "/pastes/index.html.erb"
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end


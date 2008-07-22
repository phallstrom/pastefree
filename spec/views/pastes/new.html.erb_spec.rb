require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/new.html.erb" do
  include PastesHelper
  
  before(:each) do
    @paste = mock_model(Paste)
    @paste.stub!(:new_record?).and_return(true)
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

  it "should render new form" do
    render "/pastes/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", pastes_path) do
      with_tag("textarea#paste_content[name=?]", "paste[content]")
      with_tag("select#paste_theme[name=?]", "paste[theme]")
      with_tag("select#paste_syntax[name=?]", "paste[syntax]")
      with_tag("input#paste_file_path[name=?]", "paste[file_path]")
      without_tag("input#paste_file_type[name=?]", "paste[file_type]")
      with_tag("input#paste_is_private[name=?]", "paste[is_private]")
      without_tag("input#paste_user_ip[name=?]", "paste[user_ip]")
      without_tag("input#paste_user_agent[name=?]", "paste[user_agent]")
    end
  end
end



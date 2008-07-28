require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/pastes/edit.html.erb" do
  include PastesHelper
  
  before do
    @paste = mock_model(Paste)
    @paste.stub!(:content).and_return("MyText")
    @paste.stub!(:theme_id).and_return(123)
    @paste.stub!(:syntax_id).and_return(123)
    @paste.stub!(:file_path).and_return("MyString")
    @paste.stub!(:file_type).and_return("MyString")
    @paste.stub!(:is_private).and_return(false)
    @paste.stub!(:user_ip).and_return("MyString")
    @paste.stub!(:user_agent).and_return("MyString")
    assigns[:paste] = @paste
  end

  it "should render edit form" do
    render "/pastes/edit.html.erb"
    
    response.should have_tag("form[action=#{paste_path(@paste)}][method=post]") do
      with_tag('textarea#paste_content[name=?]', "paste[content]")
      with_tag('select#paste_theme_id[name=?]', "paste[theme_id]")
      with_tag('select#paste_syntax_id[name=?]', "paste[syntax_id]")
      with_tag('input#paste_file_path[name=?]', "paste[file_path]")
      without_tag('input#paste_file_type[name=?]', "paste[file_type]")
      with_tag('input#paste_is_private[name=?]', "paste[is_private]")
      without_tag('input#paste_user_ip[name=?]', "paste[user_ip]")
      without_tag('input#paste_user_agent[name=?]', "paste[user_agent]")
    end
  end
end



require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PastesController do
  describe "route generation" do

    it "should map { :controller => 'pastes', :action => 'index' } to /pastes" do
      route_for(:controller => "pastes", :action => "index").should == "/pastes"
    end
  
    it "should map { :controller => 'pastes', :action => 'new' } to /" do
      route_for(:controller => "pastes", :action => "new").should == "/pastes/new"
    end
  
    it "should map { :controller => 'pastes', :action => 'show', :id => 1 } to /pastes/1" do
      route_for(:controller => "pastes", :action => "show", :id => 1).should == "/pastes/1"
    end
  
    it "should map { :controller => 'pastes', :action => 'edit', :id => 1 } to /pastes/1/edit" do
      route_for(:controller => "pastes", :action => "edit", :id => 1).should == "/pastes/1/edit"
    end
  
    it "should map { :controller => 'pastes', :action => 'update', :id => 1} to /pastes/1" do
      route_for(:controller => "pastes", :action => "update", :id => 1).should == "/pastes/1"
    end
  
    it "should map { :controller => 'pastes', :action => 'destroy', :id => 1} to /pastes/1" do
      route_for(:controller => "pastes", :action => "destroy", :id => 1).should == "/pastes/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'pastes', action => 'new' } from GET /" do
      params_from(:get, "/").should == {:controller => "pastes", :action => "new"}
    end

    it "should generate params { :controller => 'pastes', action => 'index' } from GET /pastes" do
      params_from(:get, "/pastes").should == {:controller => "pastes", :action => "index"}
    end
  
    it "should generate params { :controller => 'pastes', action => 'new' } from GET /pastes/new" do
      params_from(:get, "/pastes/new").should == {:controller => "pastes", :action => "new"}
    end
  
    it "should generate params { :controller => 'pastes', action => 'create' } from POST /pastes" do
      params_from(:post, "/pastes").should == {:controller => "pastes", :action => "create"}
    end
  
    it "should generate params { :controller => 'pastes', action => 'show', id => '1' } from GET /pastes/1" do
      params_from(:get, "/pastes/1").should == {:controller => "pastes", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'pastes', action => 'edit', id => '1' } from GET /pastes/1;edit" do
      params_from(:get, "/pastes/1/edit").should == {:controller => "pastes", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'pastes', action => 'update', id => '1' } from PUT /pastes/1" do
      params_from(:put, "/pastes/1").should == {:controller => "pastes", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'pastes', action => 'destroy', id => '1' } from DELETE /pastes/1" do
      params_from(:delete, "/pastes/1").should == {:controller => "pastes", :action => "destroy", :id => "1"}
    end
  end
end

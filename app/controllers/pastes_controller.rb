class PastesController < ApplicationController
  # GET /pastes
  # GET /pastes.xml
  def index
    @pastes = Paste.approved

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pastes }
    end
  end

  # GET /pastes/1
  def show
    @paste = Paste.approved.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml  {render :xml=> "Method Not Allowed", :status=>405}
    end
  end

  # GET /pastes/new
  def new
    @paste = Paste.new
    @user = User.find_by_token(session[:token])
    respond_to do |format|
      format.html 
      format.xml  {render :xml=> "Method Not Allowed", :status=>405}
    end
  end

  # GET /pastes/1/edit
  def edit
    @paste = Paste.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml  {render :xml=> "Method Not Allowed", :status=>405}
    end
  end

  # POST /pastes
  def create
    @paste = Paste.new(params[:paste])

    @user = User.find_by_token(session[:token])
    if @user.nil?
      @paste.is_approved = false
      # TODO - register the user
      # TODO - send an email
    else
      @paste.is_approved = true
    end

    respond_to do |format|
      if @paste.save
        if @paste.is_approved?
          flash[:notice] = 'Paste was successfully created.'
        else
          flash[:notice] = 'Paste was successfully created, but is pending confirmation of your email address before it will be available. Check your email.'
        end
        format.html { redirect_to(@paste) }
        format.xml  { render :xml => @paste, :status => :created, :location => @paste }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pastes/1
  def update
    @paste = Paste.find(params[:id])

    respond_to do |format|
      if @paste.update_attributes(params[:paste])
        flash[:notice] = 'Paste was successfully updated.'
        format.html { redirect_to(@paste) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pastes/1
  def destroy
    @paste = Paste.find(params[:id])
    @paste.destroy

    respond_to do |format|
      format.html { redirect_to(pastes_url) }
      format.xml  { head :ok }
    end
  end
end

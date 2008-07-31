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
    @paste = Paste.find(params[:id])

    # FIXME - handle unapproved pastes and pastes just submitted, but not approved.
    
    respond_to do |format|
      format.html # render
      format.text  { render :text => @paste.content }
      format.xml  { render :xml=> "Method Not Allowed", :status=>405 }
    end
  end

  # GET /pastes/new
  def new
    @paste = Paste.new
    @user = User.find_by_token(cookies[:token])
    respond_to do |format|
      format.html 
      format.xml  { render :xml=> "Method Not Allowed", :status=>405 }
    end
  end

  # GET /pastes/1/edit
  def edit
    @paste = Paste.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml  { render :xml=> "Method Not Allowed", :status=>405 }
    end
  end

  # 
  #
  #
  def create
    @paste = Paste.new(params[:paste])
    @user = User.find_by_token(params[:token])

    if @user.nil?
      @paste.is_approved = false
      @user = User.find_or_create_by_email(params[:email])
      ActionMailer::Base.default_url_options[:host] = request.host_with_port # an evil necessity
      Mailer.deliver_user_confirmation(@user)
    else
      @paste.is_approved = true
    end

    @paste.user = @user

    respond_to do |format|
      if @paste.save
        if @paste.is_approved?
          flash[:notice] = 'Paste was successfully created.'
        else
          flash[:notice] = 'Paste was successfully created, but is pending confirmation of your email address before it will be available. Check your email.'
        end
        # FIXME: if it's pending we can't view it. Hrm.
        format.html { redirect_to(@paste) }
        format.xml  { render :xml => @paste, :status => :created, :location => @paste }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paste.errors, :status => :unprocessable_entity }
      end
    end
  end

  # 
  #
  #
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

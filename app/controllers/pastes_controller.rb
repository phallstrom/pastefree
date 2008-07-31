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

    
    action = "show"
    action = "show_pending" if !@paste.is_approved?

    respond_to do |format|
      format.html { render :action => action }
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
    @errors = []

    @errors << @paste.errors.full_messages unless @paste.valid?
    @errors << "Your email address is required" if params[:email].blank? && @user.nil?

    unless @errors.empty?
      respond_to do |format|
        format.html { render :action => "new" }
        format.xml  { render :xml => @errors, :status => :unprocessable_entity }
      end
      return
    end

    # FIXME - if you lose your cookie you can just type in any valid email and it works. that's not good

    if @user.nil?
      @user = User.find_or_create_by_email(params[:email])

      unless @user.valid?
        @errors << @user.errors.full_messages
        respond_to do |format|
          format.html { render :action => "new" }
          format.xml  { render :xml => @errors, :status => :unprocessable_entity }
        end
        return
      end

      unless @user.is_confirmed?
        ActionMailer::Base.default_url_options[:host] = request.host_with_port # an evil necessity
        Mailer.deliver_user_confirmation(@user)
      end
    end

    @paste.is_approved = @user.is_confirmed?
    @paste.user = @user

    respond_to do |format|
      if @paste.save
        format.html { redirect_to(@paste) }
        format.xml  { render :xml => @paste, :status => :created, :location => @paste }
      else
        @errors << @paste.errors.full_messages 
        @errors << @user.errors.full_messages
        format.html { render :action => "new" }
        format.xml  { render :xml => @errors, :status => :unprocessable_entity }
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

  #
  #
  #
  def auto_complete_belongs_to_for_paste_syntax_name
    @syntaxes = Syntax.find(:all,
                        :conditions => ['LOWER(name) LIKE ?', '%' + params[:syntax][:name].downcase + '%'],
                        :order => 'paste_count, name',
                        :limit => 10)
    render :inline => '<%= model_auto_completer_result(@syntaxes, :name,  params[:syntax][:name].downcase) %>'
  end


end

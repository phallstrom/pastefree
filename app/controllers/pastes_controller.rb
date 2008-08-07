class PastesController < ApplicationController

  before_filter :find_user_by_token, :except => ['create']

  # 
  #
  #
  def index
    respond_to do |format|
      format.html { redirect_to new_paste_path }
      format.xml  { render :xml=> "Method Not Allowed", :status => 405 }
    end
  end

  #
  #
  #
  def mine
    if @user
      @pastes = @user.pastes.paginate :page => params[:page], :per_page => 5
    else
      render :action => 'no_pastes_for_you'
      return
    end
  end

  # 
  #
  #
  def show
    @paste = Paste.find(params[:id])

    action = "show"
    action = "show_pending" if !@paste.is_approved?

    respond_to do |format|
      format.html { render :action => action }
      format.text  { render :text => @paste.content }
      format.xml  { render :xml=> "Method Not Allowed", :status => 405 }
    end
  end

  #
  #
  #
  def new
    @paste = Paste.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml=> "Method Not Allowed", :status => 405 }
    end
  end

  #
  #
  #
  def edit
    respond_to do |format|
      format.html { render :text => "Method Not Allowed", :status => 405 }
      format.xml  { render :xml=> "Method Not Allowed", :status => 405 }
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

      # force them to reconfirm
      @user.update_attribute(:is_confirmed, false) unless @user.new_record?

      ActionMailer::Base.default_url_options[:host] = request.host_with_port # an evil necessity
      Mailer.deliver_user_confirmation(@user)
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
    respond_to do |format|
      format.html { render :text => "Method Not Allowed", :status => 405 }
      format.xml  { render :xml=> "Method Not Allowed", :status => 405 }
    end
  end

  # 
  #
  #
  def destroy
    respond_to do |format|
      format.html { render :text => "Method Not Allowed", :status => 405 }
      format.xml  { render :xml=> "Method Not Allowed", :status => 405 }
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

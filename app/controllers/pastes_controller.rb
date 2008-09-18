class PastesController < ApplicationController

  caches_page :show

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
  def show
    @paste = Paste.find(params[:id])

    respond_to do |format|
      format.html
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
    @paste.is_approved = true

    respond_to do |format|
      if @paste.save
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

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '76369d225856b480788fb261ee911c5c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :browser_check, :except => 'time_to_upgrade'

  private ############################################################

  def browser_check
    if request.env['HTTP_USER_AGENT'] =~ /MSIE 6.0/
      redirect_to time_to_upgrade_path
      return false
    end

    return true
  end
end

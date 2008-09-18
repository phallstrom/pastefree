class HomeController < ApplicationController

  caches_page :time_to_upgrade

  #
  #
  #
  def time_to_upgrade
    render :layout => false
  end

end

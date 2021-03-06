ActionController::Routing::Routes.draw do |map|

  map.resources :pastes, :collection => {:mine => :get}

  map.root :controller => 'pastes', :action => 'new'

  map.about '/about', :controller => 'home', :action => 'about'
  map.time_to_upgrade '/time-to-upgrade-your-browser', :controller => 'home', :action => 'time_to_upgrade'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

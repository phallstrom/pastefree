ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pastes', :action => 'new'

  map.resources :pastes, :collection => {:mine => :get}


  map.statistics '/statistics', :controller => 'home', :action => 'statistics'
  map.about '/about', :controller => 'home', :action => 'about'
  map.signout '/signout', :controller => 'home', :action => 'signout'
  map.signin '/signin', :controller => 'home', :action => 'signin'
  map.time_to_upgrade '/time-to-upgrade-your-browser', :controller => 'home', :action => 'time_to_upgrade'
  map.confirm_user '/confirm/:token', :controller => 'home', :action => 'confirm_user'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

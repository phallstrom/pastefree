ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pastes', :action => 'new'

  map.resources :pastes

  map.statistics '/statistics', :controller => 'home', :action => 'statistics'
  map.about '/about', :controller => 'home', :action => 'about'
  map.confirm_user '/confirm/:token', :controller => 'home', :action => 'confirm_user'

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

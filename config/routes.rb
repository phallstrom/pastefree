ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pastes', :action => 'new'

  map.resources :pastes

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

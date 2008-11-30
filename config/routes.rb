ActionController::Routing::Routes.draw do |map|
  map.resources :pages do |pages|
    pages.resources :versions, :only => [:index, :show] do |versions|
      versions.resources :diffs, :as => 'diff', :only => [:show]
    end
    
    pages.resources :diffs, :as => 'diff', :only => [:show]
  end
  
  map.resource :session
  
  map.login 'login', :controller => 'sessions', :action => 'new', :conditions => {:method => :get}
  
  map.root :controller => 'pages', :action => 'show', :id => 'home'

  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end

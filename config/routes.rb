Up2u::Application.routes.draw do
  devise_for :usuarios, 
  :path => "", 
  :path_names => { 
    :sign_in => "home", 
    :sign_out => "sair", 
    :sign_up => "home" 
  },
  :controllers => { :omniauth_callbacks => "usuarios/omniauth_callbacks"}

  authenticated :usuario do
    root to: "areas#index"
  end
  unauthenticated :usuario do
    root to: redirect("/home")
  end

  resources :areas, only: [:index]
end

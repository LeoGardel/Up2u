Up2u::Application.routes.draw do
  devise_for :usuarios, 
  :path => "", 
  :path_names => { 
    :sign_in => "home", 
    :sign_out => "sair", 
    :sign_up => "home",
    :password => 'dadosPessoais',
    :confirmation => 'confirmacao'
  },
  :controllers => { :omniauth_callbacks => "usuarios/omniauth_callbacks"}

  authenticated :usuario do
    root to: "painel_usuario#index"
  end
  unauthenticated :usuario do
    root to: redirect("/home")
  end

  resources :painel_usuario, only: [:index]
end

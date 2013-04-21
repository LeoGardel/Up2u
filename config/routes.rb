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
    root to: "dashboard#index"
  end
  unauthenticated :usuario do
    root to: redirect("/home")
  end

  resources :dashboard, only: [:index]
  match "dashboard/editar_cargo_area" => "dashboard#editar_cargo_area", as: :dashboard_editar_cargo_area, via: :get
  match "dashboard/editar_cargo_area" => "dashboard#salvar_cargo_area", as: :dashboard_salvar_cargo_area, via: :post
end

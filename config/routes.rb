Up2u::Application.routes.draw do
  devise_for :usuarios, skip: :registrations,
  :path => "", 
  :path_names => { 
    :sign_in => "inicio", 
    :sign_out => "sair", 
    :password => 'senha',
    :confirmation => 'confirmacao'
  },
  :controllers => { :omniauth_callbacks => "usuarios/omniauth_callbacks"}

  devise_scope :usuario do
    resource :registration,
      only: [:new, :create, :update],
      path: "",
      path_names: { new: 'inicio' },
      controller: 'registrations',
      as: :usuario_registration do
        get :cancel
      end
    match 'edit' => 'registrations#edit', :via => :get, :as => :edit_usuario_registration
  end

  authenticated :usuario do
    root to: "dashboard#index"
  end
  unauthenticated :usuario do
    root to: redirect("/inicio")
  end

  resources :dashboard, only: [:index]
  match "dashboard/editar_cargo_area" => "dashboard#editar_cargo_area", as: :dashboard_editar_cargo_area, via: :get
  match "dashboard/editar_cargo_area" => "dashboard#salvar_cargo_area", as: :dashboard_salvar_cargo_area, via: :post
  match "dashboard/atualizar_cargo_area" => "dashboard#atualizar_cargo_area", as: :dashboard_atualizar_cargo_area, via: :post
  
  match "questionario_competencias/instrucoes" => "questionario_competencias#instrucoes",
   as: :questionario_competencias_instrucoes, via: :get
  match "questionario_competencias/prox_pergunta" => "questionario_competencias#prox_pergunta",
   as: :questionario_competencias_prox_pergunta, via: :get
  match "questionario_competencias/registrar_resposta" => "questionario_competencias#registrar_resposta",
   as: :questionario_competencias_registrar_resposta, via: :post
  match "questionario_competencias/resultados" => "questionario_competencias#resultados",
   as: :questionario_competencias_resultados, via: :get

  match "questionario_perfil/instrucoes" => "questionario_perfil#instrucoes",
   as: :questionario_perfil_instrucoes, via: :get
  match "questionario_perfil/prox_pergunta" => "questionario_perfil#prox_pergunta",
   as: :questionario_perfil_prox_pergunta, via: :get
  match "questionario_perfil/registrar_resposta" => "questionario_perfil#registrar_resposta",
   as: :questionario_perfil_registrar_resposta, via: :post
  match "questionario_perfil/resultados" => "questionario_perfil#resultados",
   as: :questionario_perfil_resultados, via: :get

  match "sobre_nos" => "static_pages#sobre_nos",
   as: :sobre_nos, via: :get
end

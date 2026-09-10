Rails.application.routes.draw do
  get "users/index"
  get "users/edit"
  devise_for :users

  resources :users, only: [:index, :edit, :update, :destroy]
  resources :servicio_maquinarias
  
  resources :asignacion_maquinaria_metas
  resources :maquinarias
  resources :meta_notificaciones
  resources :unidades
  resources :metas
  resources :servicios
  resources :asignacion_metas


  resources :control_servicio_maquinarias,
            only: [:index] do

    collection do
      post :actualizar
    end

  end

  resources :control_servicios do
    collection do
      post :enviar_notificaciones
    end
  end
    
  resources :unidades do
    collection do
      post :sync_from_api
    end
  end

  get  "control_servicios", to: "control_servicios#index"
  post "unidades/sincronizar", to: "unidades#sincronizar", as: :sincronizar_unidades

  post "control_servicios/actualizar",
       to: "control_servicios#actualizar",
       as: :actualizar_control_servicios

  resources :odometers, only: [:index]
  resources :locations, only: [:index]

  namespace :api do
    post "/cymsas/import", to: "cymsas#import"
    post "/cymsas/upload", to: "cymsas#upload"
  end
  root "control_servicios#index"
  resources :reports, only: [:index]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end

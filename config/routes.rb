Classtrack4::Application.routes.draw do
  devise_for :administrators

  resources :students
  resources :subscriptions, only: :destroy
  resources :semesters
  resources :courses, only: :index

  match '/sms_configuration' => 'pages#sms_configuration', as: :sms

  root to: "students#new"
end

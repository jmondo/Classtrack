Classtrack4::Application.routes.draw do
  devise_for :administrators

  resources :students
  resources :subscriptions, only: :destroy
  resources :semesters

  root to: "students#new"
end

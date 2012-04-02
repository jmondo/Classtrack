Classtrack4::Application.routes.draw do
  resources :students
  resources :subscriptions, only: :destroy

  root to: "students#new"
end

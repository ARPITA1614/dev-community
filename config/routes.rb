Rails.application.routes.draw do
  devise_for :users
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
  get "member/:id", to: "members#show", as: "member"
  get "edit_description/:id", to: "members#edit_description", as: "edit_member_description"
end

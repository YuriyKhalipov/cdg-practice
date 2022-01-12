Rails.application.routes.draw do
  devise_for :users
  resources :lab_reports
  
  get '/lab_reports/:id/mark', to: 'lab_reports#mark', as: 'mark_lab_report'

  root "lab_reports#index"
end

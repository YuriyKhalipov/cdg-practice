Rails.application.routes.draw do
  root 'laboratory_works#index'
  get '/laboratory_works/new', to: 'laboratory_works#new', as: 'new_lab'
  post '/laboratory_works', to: 'laboratory_works#create'

  get '/laboratory_works/:id', to: 'laboratory_works#show', as: 'lab'

  get '/laboratory_works/:id/edit', to: 'laboratory_works#edit', as: 'edit_lab'
  post '/laboratory_works/:id/edit', to: 'laboratory_works#update'
  patch '/laboratory_works/:id', to: 'laboratory_works#update'

  delete '/laboratory_works/:id', to: 'laboratory_works#destroy'

  get '/laboratory_works/:id/mark', to: 'laboratory_works#mark', as: 'mark_lab'
  post '/laboratory_works/:id/mark', to: 'laboratory_works#grade'
end

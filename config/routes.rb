Rails.application.routes.draw do
  get 'sessions/new'

  resources :expertises
  resources :skills
  resources :experts
  resources :todos
  resources :questions
  post '/question_form', to: 'experts#load_expert_form'
  get '/question_form', to: 'experts#submit_question'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/search', to: 'questions#search'
  post '/submit_question', to: 'experts#submit_question'
  post '/find_expertises', to: 'experts#find_expertises'
  get '/update_expertises', to: 'experts#load_expert_lookup'
  root 'home#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :expertises
  resources :skills
  resources :experts
  resources :todos
  resources :questions
  post '/question_form', to: 'experts#load_expert_form'
  get '/search', to: 'questions#search'
  get '/submit_question', to: 'experts#submit_question'
  root 'home#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

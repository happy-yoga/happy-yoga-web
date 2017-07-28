Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/destroy'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/new')
  delete 'signout', to: 'sessions#destroy', as: 'signout'


  get 'pages/landing_page'

  root 'pages#landing_page'
end

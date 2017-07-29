Rails.application.routes.draw do
  get 'pages/landing_page'


  namespace 'edit', module: 'admin', as: 'admin' do
    get 'sessions/new'

    # authentication
    get 'sessions/destroy'
    get '/auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/new')
    delete 'signout', to: 'sessions#destroy', as: 'signout'

    get '/', to: 'pages#index'
  end

  root 'pages#landing_page'
end

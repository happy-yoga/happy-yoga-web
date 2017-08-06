Rails.application.routes.draw do
  get 'translations/index'


  get 'pages/landing_page'


  # oauth endpoints
  get '/auth/:provider/callback', to: 'admin/sessions#create'
  get 'auth/failure', to: redirect('/edit/sessions/new')


  namespace 'edit', module: 'admin', as: 'admin' do
    resources :contents

    resources :translations, constraints: { :id => /[^\/]+/ }

    # authentication management
    get 'sessions/new'
    get 'sessions/destroy'
    delete 'signout', to: 'sessions#destroy', as: 'signout'

    get '/', to: 'pages#index'
  end

  root 'pages#landing_page'
end

Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'pages/landing_page'

  root 'pages#landing_page'
end

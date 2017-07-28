Rails.application.routes.draw do
  get 'pages/landing_page'

  root 'pages#landing_page'
end

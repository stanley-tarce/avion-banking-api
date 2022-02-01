Rails.application.routes.draw do
  resources :accounts
  patch 'accounts/:id/withdraw', to: 'accounts#withdraw'
  patch 'accounts/:id/deposit', to: 'accounts#deposit'
  patch 'accounts/:id/transfer', to: 'accounts#transfer'
  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

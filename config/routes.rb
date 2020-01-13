Rails.application.routes.draw do
  resources :events do
    resources :days do
      resources :blocks
    end
  end

  root to: "events#index"
end

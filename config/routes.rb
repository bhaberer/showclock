Rails.application.routes.draw do
  resources :events do
    resources :days do
      get 'timer', to: 'days#timer'
      resources :blocks do
        scope :move do
          put 'earlier', to: 'blocks#move_earlier', as: 'move_earlier'
          put 'later', to: 'blocks#move_later', as: 'move_later'
        end
      end
    end
  end

  root to: "events#index"
end

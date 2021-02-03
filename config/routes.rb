Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: 'api' do
    namespace 'v1' do
      resources :follows, only: [] do
        get :time_tracks
        delete :unfollow
        collection do
          post :follow
        end
      end

      resources :time_tracks, only: [:index, :create]
    end
  end
  get '*path', controller: 'application', action: 'render_404'
end

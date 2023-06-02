RedmineApp::Application.routes.draw do
  resources :issues do
    collection do
      post :calculate_due_date
    end
  end
end

Rails.application.routes.draw do
  #resources :blog_posts haalt de routes weg uit de code en verwerkt alles op de achtergrond.

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  get "/blog_posts/new", to: "blog_posts#new", as: :new_blog_post

  get "/blog_posts/:id", to: "blog_posts#show", as: :blog_post

  patch "/blog_posts/:id", to: "blog_posts#update"

  delete "/blog_posts/:id", to: "blog_posts#destroy"

  get "/blog_posts/:id/edit/", to: "blog_posts#edit", as: :edit_blog_post

  post "blog_posts", to: "blog_posts#create", as: :blog_posts

  patch "/blog_posts/:id/like", to: "blog_posts#like", as: :like_blog_post

  delete "/blog_posts/:id/like", to: "blog_posts#unlike", as: :unlike_blog_post

  get "/debug", to: "blog_posts#debug"

  # Defines the root path route ("/")
  root "blog_posts#index"
end

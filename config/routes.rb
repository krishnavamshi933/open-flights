Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "api/v2/graphql"
  end

  # Catch-all route
  get '*path', to: 'pages#index', via: :all

  root 'pages#index'

  # Other routes here...
end

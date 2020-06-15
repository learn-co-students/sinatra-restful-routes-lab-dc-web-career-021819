class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
  end

  # code actions here!
  get "/" do
    redirect "/recipes"
  end

  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  post "/recipes" do
    name = params[:name]
    cook_time = params[:cook_time]
    ingredients = params[:ingredients]
    @recipe = Recipe.create(name: name, ingredients: ingredients, cook_time: cook_time)
    redirect "/recipes/#{@recipe.id}"
  end

  delete "/recipes/:id" do
    Recipe.delete(params[:id])
    redirect "/recipes"
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    name = params[:name]
    ingredients = params[:ingredients]
    cook_time = params[:cook_time]
    @recipe.name = name
    @recipe.ingredients = ingredients
    @recipe.cook_time = cook_time
    @recipe.save
    redirect "/recipes/#{@recipe.id}"
  end
end

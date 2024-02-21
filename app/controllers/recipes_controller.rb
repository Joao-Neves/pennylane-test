class RecipesController < ApplicationController
  def index
    ingredients = params[:query]
    return @recipes = Recipe.all if ingredients.nil? || ingredients.empty?

    @recipes = SearchRecipes.by_ingredients(ingredients.split(' '))
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  def search
    ingredients = params[:ingredients]
    return render json: [] if ingredients.nil? || ingredients.empty?

    render json: SearchRecipes.by_ingredients(ingredients.split(',')).to_json(include: :ingredients)

  rescue StandardError => e
    render status: :internal_server_error, json: { error: 'Something went wrong, please try again later', error_message: e.message }
  end
end

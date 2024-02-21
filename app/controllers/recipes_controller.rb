class RecipesController < ApplicationController
  PAGE_SIZE = 10
  private_constant :PAGE_SIZE
  def index
    ingredients = params[:query]
    if ingredients.blank?
      @pagy, @recipes = pagy(Recipe.all, items: PAGE_SIZE)
      return
    end

    @query = ingredients
    @pagy, @recipes = pagy(SearchRecipes.by_ingredients(ingredients.split(' ')), items: PAGE_SIZE)
  end

  def show
    @query = params[:query]
    @page = params[:page]
    @recipe = Recipe.find(params[:id])
  end
  def search
    ingredients = params[:ingredients]
    return render json: [] if ingredients.blank?

    render json: SearchRecipes.by_ingredients(ingredients.split(',')).to_json(include: :ingredients)

  rescue StandardError => e
    render status: :internal_server_error, json: { error: 'Something went wrong, please try again later', error_message: e.message }
  end
end

class RecipesController < ApplicationController
  def search
    ingredients = params[:ingredients]

    return render json: [] if ingredients.nil? || ingredients.empty?

    ingredients_array = ingredients.split(',')
    ingredients_query = ingredients_array.map { 'name_and_quantity like ?' }.join(' or ')

    render json: Recipe.joins(:ingredients).where(ingredients_query, *ingredients_array.map { |i| "%#{i}%" }).to_json(include: :ingredients)

  rescue StandardError => e
    render status: :internal_server_error, json: { error: 'Something went wrong, please try again later', error_message: e.message }
  end
end

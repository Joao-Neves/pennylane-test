# frozen_string_literal: true

class SearchRecipes
  def self.by_ingredients(ingredients)
    ingredients_query = ingredients.map { 'name_and_quantity like ?' }.join(' or ')

    Recipe.joins(:ingredients)
          .where(ingredients_query, *ingredients.map { |i| "%#{i}%" })
          .uniq
  end
end

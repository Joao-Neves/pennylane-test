# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

JSON.parse(File.read('./db/recipes-en.json')).each do |recipe|
  recipe_object = Recipe.create(
    title: recipe['title'],
    cook_time: recipe['cook_time'],
    prep_time: recipe['prep_time'],
    ratings: recipe['ratings'],
    cuisine: recipe['cuisine'],
    category: recipe['category'],
    author: recipe['author'],
    image: recipe['image'],
  )

  recipe['ingredients'].each do |ingredient|
    Ingredient.create(name_and_quantity: ingredient, recipe: recipe_object)
  end
end
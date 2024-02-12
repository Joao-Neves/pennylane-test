# frozen_string_literal: true

require 'rspec'
require 'rails_helper'

RSpec.describe 'RecipesController', type: :request do

  describe 'GET /recipes/search' do
    context 'when no ingredients are passed' do
      it 'returns an empty response' do
        get '/recipes/search'

        expect(response.body).to eq([].to_json)
      end
    end

    context 'when ingredients are passed' do
      let!(:cozido_a_portuguesa) {
        recipe_object = Recipe.create(
          title: 'Cozido à Portuguesa',
          cook_time: 45,
          prep_time: 15,
          ratings: 3.7,
          cuisine: 'Portuguese',
          category: 'Main course',
          author: 'João Neves',
          image: 'https://1.bp.blogspot.com/-IMOP-HSfZeY/YBNC3gYGCwI/AAAAAAAACaI/Z8xM_Y60bc8qz56OQHZC1l6IrqE889yMgCNcBGAsYHQ/s2000/3.jpg',
          )

        Ingredient.create(name_and_quantity: '300g potatoes', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '300g beef', recipe: recipe_object)
        Ingredient.create(name_and_quantity: 'Half a chicken', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '300g pork', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '100g ham', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '200g carrots', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '100g chorizo', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '100g portuguese cabbage', recipe: recipe_object)
        Ingredient.create(name_and_quantity: 'salt', recipe: recipe_object)
        Ingredient.create(name_and_quantity: 'olive oil', recipe: recipe_object)

        recipe_object
      }

      let!(:carrot_soup) {
        recipe_object = Recipe.create(
          title: 'Carrot Soup',
          cook_time: 53,
          prep_time: 22,
          ratings: 2.8,
          cuisine: '',
          category: 'Soup',
          author: 'Jon Snow',
          image: 'https://thestayathomechef.com/wp-content/uploads/2018/10/Carrot-Soup-THUMBNAIL.jpg',
          )

        Ingredient.create(name_and_quantity: '2 tablespoons unsalted butter', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '1 large white onion, chopped', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '2 pounds carrots, peeled and chopped', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '3 clove garlic, chopped', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '1 teaspoon dried thyme', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '4 cups vegetable stock', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '1/2 teaspoon salt', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '1/2 teaspoon white pepper, optional', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '4 tablespoons heavy cream, divided', recipe: recipe_object)

        recipe_object
      }

      let!(:pastel_de_nata) {
        recipe_object = Recipe.create(
          title: 'Pastel de Nata',
          cook_time: 37,
          prep_time: 12,
          ratings: 4.7,
          cuisine: '',
          category: 'Dessert',
          author: 'João Neves',
          image: 'https://leserialpatissteur.com/wp-content/uploads/2018/07/pasteis-de-nata-fabrica-da-nata.jpg',
          )

        Ingredient.create(name_and_quantity: '1 rectangular puff pastry', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '250 ml milk', recipe: recipe_object)
        Ingredient.create(name_and_quantity: 'lemon peel', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '30 gr wheat flour', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '150 gr sugar', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '75 ml water', recipe: recipe_object)
        Ingredient.create(name_and_quantity: '4 egg yolks', recipe: recipe_object)

        recipe_object
      }

      context 'when a single ingredient is passed' do
        it 'returns all the relevant recipes' do
          get '/recipes/search?ingredients=carrots'

          expect(response.body).to eq([cozido_a_portuguesa, carrot_soup].to_json(include: :ingredients))
        end
      end

      context 'when multiple ingredients are passed' do
        it 'returns all the relevant recipes' do
          get '/recipes/search?ingredients=carrots,yolks'

          expect(response.body).to eq([cozido_a_portuguesa, carrot_soup, pastel_de_nata].to_json(include: :ingredients))
        end
      end
    end
  end

  context 'when the DB raises an error' do
    let(:error_message) { 'The DB has crashed' }
    before do
      allow(Recipe).to receive(:joins).and_raise(StandardError.new(error_message))
    end

    it 'returns a 500 error with the error message' do
      get '/recipes/search?ingredients=carrots,yolks'

      expect(response.status).to eq(500)
      expect(response.body).to eq({
                                    error: 'Something went wrong, please try again later',
                                    error_message: error_message
                                  }.to_json)
    end
  end
end

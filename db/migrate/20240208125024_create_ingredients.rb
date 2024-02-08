class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :name_and_quantity
      t.references :recipe

      t.timestamps
    end
  end
end
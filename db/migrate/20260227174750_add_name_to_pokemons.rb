class AddNameToPokemons < ActiveRecord::Migration[8.1]
  def change
    add_column :pokemons, :name, :string
  end
end

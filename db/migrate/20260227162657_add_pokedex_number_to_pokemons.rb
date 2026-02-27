class AddPokedexNumberToPokemons < ActiveRecord::Migration[8.1]
  def change
    add_column :pokemons, :pokedex_number, :integer
  end
end

class AddFieldsToPokemons < ActiveRecord::Migration[7.0]
  def change
    add_column :pokemons, :pokedex_number, :integer unless column_exists?(:pokemons, :pokedex_number)
    add_column :pokemons, :image_url, :string       unless column_exists?(:pokemons, :image_url)
    add_column :pokemons, :types, :string           unless column_exists?(:pokemons, :types)
    add_column :pokemons, :height, :integer         unless column_exists?(:pokemons, :height)
    add_column :pokemons, :weight, :integer         unless column_exists?(:pokemons, :weight)
    add_column :pokemons, :abilities, :string       unless column_exists?(:pokemons, :abilities)
  end
end

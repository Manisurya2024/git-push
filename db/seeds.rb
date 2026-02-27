puts "=== SEEDS START ==="

Pokemon.delete_all

puts "Fetching Pokémon..."
pokemons = PokemonApi.fetch(50)

pokemons.each do |p|
  Pokemon.create!(
    name: p[:name].capitalize,
    pokedex_number: p[:id],
    image_url: p[:image],
    types: p[:types].join(", "),
    height: p[:height],
    weight: p[:weight],
    abilities: p[:abilities].join(", ")
  )
end

puts "Inserted #{Pokemon.count} Pokémon"
puts "=== SEEDS END ==="
require 'net/http'
require 'json'

class PokemonApi
  BASE_URL = "https://pokeapi.co/api/v2/pokemon"

  def self.fetch(limit = 20)
    url = URI("#{BASE_URL}?limit=#{limit}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    return [] unless data["results"]

    data["results"].each_with_index.map do |p, index|
      id = index + 1
      details = fetch_details(id)

      {
        id: id,
        name: p["name"],
        image: details.dig("sprites","front_default"),
        types: (details["types"] || []).map { |t| t.dig("type","name") },
        height: details["height"],
        weight: details["weight"],
        abilities: (details["abilities"] || []).map { |a| a.dig("ability","name") }
      }
    end
  end

  def self.fetch_details(id)
    url = URI("#{BASE_URL}/#{id}")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  rescue
    {}
  end
end
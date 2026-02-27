# app/models/pokemon.rb
require "net/http"
require "json"
class PokemonApi
  BASE_URL = "https://pokeapi.co/api/v2/pokemon".freeze

  # fetch list of pokemon (shallow info + look up details for sprites/types)
  # limit: integer
  def self.fetch(limit = 20)
    url = URI("#{BASE_URL}?limit=#{limit}")
    json = Net::HTTP.get(url)
    data = JSON.parse(json) rescue nil
    return [] unless data && data["results"].is_a?(Array)

    # Use each_with_index so id is predictable (1..N) per original lesson
    data["results"].each_with_index.map do |p, i|
      id = i + 1
      details = begin
                  fetch_details(id)
                rescue StandardError
                  {}
                end

      {
        id: id,
        name: p["name"],
        image: details.dig("sprites", "front_default"),
        types: (details["types"] || []).map { |t| t.dig("type", "name") },
        height: details["height"],
        weight: details["weight"],
        abilities: (details["abilities"] || []).map { |a| a.dig("ability","name") }
      }
    end
  end

  # fetch details for single pokemon id
  def self.fetch_details(id)
    url = URI("#{BASE_URL}/#{id}")
    json = Net::HTTP.get(url)
    JSON.parse(json)
  end
end
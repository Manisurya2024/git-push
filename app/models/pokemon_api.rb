require 'httparty'
require 'cgi'

class PokemonApi
include HTTParty
base_uri 'https://pokeapi.co/api/v2'

def self.index(limit = 20)
resp = get("/pokemon?limit=#{limit}")
return [] unless resp.success?

results = resp['results'] || []
results.map { |r| fetch_by_name(r['name']) }.compact

end

def self.fetch_by_name(name)
return nil if name.to_s.strip == ''
resp = get("/pokemon/#{CGI.escape(name.to_s.downcase)}")
return nil unless resp.success?

parse_pokemon(resp.parsed_response)

end

def self.parse_pokemon(raw)
return nil unless raw
{
id: raw['id'],
name: raw['name'],
height: raw['height'],
weight: raw['weight'],
types: raw['types']&.map { |t| t['type']['name'] } || [],
image: raw.dig('sprites','front_default')
}
end
end
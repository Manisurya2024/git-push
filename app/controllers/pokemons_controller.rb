class PokemonsController < ApplicationController
  def index
    per_page = params[:per_page].presence || 20
    @per_page = per_page.to_i.clamp(5, 200)

    @q = params[:q].to_s.strip

    base = Pokemon.order(:pokedex_number)
    base = base.where("name LIKE ?", "%#{@q}%") if @q.present?

    @pokemons = base.limit(500)
    @cards = @pokemons.first(@per_page)
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
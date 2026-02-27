# app/models/pokemon.rb
class Pokemon < ApplicationRecord
  # Return an Array for types (robust parsing)
  def types_array
    parse_array_column(self[:types])
  end

  def abilities_array
    parse_array_column(self[:abilities])
  end

  # Primary and secondary type helpers (used by views)
  def primary_type
    types_array[0]
  end

  def secondary_type
    types_array[1]
  end

  # Prefer image_url column but fall back to image if present
  def image
    self[:image_url].presence || self[:image]
  end

  # Presentation helpers
  def types_to_s
    types_array.join(", ")
  end

  def abilities_to_s
    abilities_array.join(", ")
  end

  private

  # parse_array_column accepts:
  #  - already an Array
  #  - a JSON array string like '["grass","poison"]'
  #  - a comma-separated string like "grass, poison"
  #  - nil -> []
  def parse_array_column(value)
    return [] if value.nil?

    return value if value.is_a?(Array)

    if value.is_a?(String)
      stripped = value.strip
      # JSON array string?
      if stripped.start_with?("[") && stripped.end_with?("]")
        begin
          parsed = JSON.parse(stripped)
          return parsed if parsed.is_a?(Array)
        rescue JSON::ParserError
          # fall through to comma-split
        end
      end

      # comma-separated string
      return stripped.split(",").map(&:strip)
    end

    [] # fallback
  end
end
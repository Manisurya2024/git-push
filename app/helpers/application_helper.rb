module ApplicationHelper
  TYPE_CLASS = {
    "grass" => "badge-type-grass",
    "fire" => "badge-type-fire",
    "water" => "badge-type-water",
    "bug" => "badge-type-bug",
    "normal" => "badge-type-normal",
    "poison" => "badge-type-poison",
    "flying" => "badge-type-flying"
  }.freeze

  def pokemon_type_class(type)
    return "badge bg-secondary" unless type.present?
    TYPE_CLASS[type.downcase] || "badge bg-secondary"
  end
end
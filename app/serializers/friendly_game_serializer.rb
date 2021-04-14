class FriendlyGameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current_fen
  belongs_to :white
  belongs_to :black
end

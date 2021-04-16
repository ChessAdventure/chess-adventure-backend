class FriendlyGameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :extension, :current_fen
end

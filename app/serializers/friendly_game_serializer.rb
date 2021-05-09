class FriendlyGameSerializer
  include JSONAPI::Serializer
  attributes :extension, :current_fen

  attribute :white do |game|
    game.white.username rescue nil
  end

  attribute :black do |game|
    game.black.username rescue nil
  end
end

require 'rails_helper'

describe Game do
  describe "The Game" do
    before :each do
      @data = {
            id: "1",
            "type": "game",
            attributes: {
              status: "in_progress",
              quest_id: "1",
              current_fen: "rnbqkbnr/pppppppp/8/8/8/8/8/RNBQKBNR w KQkq - 0 1"
            }
          }
      @game = Game.new(@data)
    end

    it 'has attributes' do
      expect(@game.status).to eq(@data[:attributes][:status])
      expect(@game.quest_id).to eq(@data[:attributes][:quest_id])
      expect(@game.fen).to eq(@data[:attributes][:current_fen])
    end
  end
end
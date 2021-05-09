require 'rails_helper'

describe Fen do
  describe "The Game" do
    before :each do
      @data = "rnbqkbnr/pppppppp/8/8/8/8/7K/RNBQ1BNR w KQkq - 0 1"
      @no_pawn_fen = Fen.new(@data)
      @data = "rnbqkbnr/pppppppp/8/8/7P/1PPPPPPP/RNBQKBNR w KQkq - 0 1"
      @full_fen = Fen.new(@data)
      @data = "rnbqkbnr/pppppppp/8/8/7P/5PPP/RNBQKBN1 w KQkq - 0 1"
      @half_pawn_fen = Fen.new(@data)
    end

    it 'properly washes fens' do
      # expect(@no_pawn_fen.to_starting_position.fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/8/RNBQKBNR w KQkq - 0 1')
      # expect(@half_pawn_fen.to_starting_position.fen).to eq('rnbqkbnr/pppppppp/8/8/8/8/4PPPP/RNBQKBNR w KQkq - 0 1')
    end
  end
end
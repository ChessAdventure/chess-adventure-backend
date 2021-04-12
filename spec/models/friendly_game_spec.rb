require 'rails_helper'

describe FriendlyGame, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:current_fen).on(:update) }
    it { should validate_presence_of :starting_fen }
  end

  describe 'relationships' do
    it { should belong_to :white }
    it { should belong_to :black }
  end
end

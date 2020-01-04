require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do

    context 'required' do
      let(:user) { FactoryBot.create(:user) }

      it "is valid with a user_id, asin, and status" do
        game = user.games.new(asin: 1, status: 1)
        expect(game).to be_valid
      end

      it "is invalid without an asin" do
        game = user.games.new(asin: nil, status: 1)
        game.valid?
        expect(game.errors[:asin]).to include("can't be blank")
      end

      it "is invalid without a status" do
        game = user.games.new(asin: 1, status: nil)
        game.valid?
        expect(game.errors[:status]).to include("can't be blank")
      end
    end
  end
end

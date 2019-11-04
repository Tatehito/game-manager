require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    it "is valid with a uid, asin, and status" do
      game = Game.new(
        uid: 123456789,
        asin: 1234567890,
        status: 1
      )
      expect(game).to be_valid
    end

    it "is invalid without a uid" do
      game = FactoryBot.build(:game, uid: nil)
      game.valid?
      expect(game.errors[:uid]).to include("can't be blank")
    end

    it "is invalid without an asin" do
      game = FactoryBot.build(:game, asin: nil)
      game.valid?
      expect(game.errors[:asin]).to include("can't be blank")
    end

    it "is invalid without a status" do
      game = FactoryBot.build(:game, status: nil)
      game.valid?
      expect(game.errors[:status]).to include("can't be blank")
    end

    context 'duplicate errors' do
      before do
        Game.create(
          uid: 123456789,
          asin: 1234567890,
          status: 1
        )
      end

      it "is invalid with a duplicate uid and asin" do
        game = Game.new(
          uid: 123456789,
          asin: 1234567890,
          status: 2
        )
        game.valid?
        expect(game.errors[:uid]).to include("has already been taken")
      end

      it "is valid with a diffent uid and a same asin" do
        game = Game.new(
          uid: 999999999,
          asin: 1234567890,
          status: 2
        )
        expect(game.valid?).to be_truthy
      end

      it "is valid with a same asin and a diffent uid" do
        game = Game.new(
          uid: 123456789,
          asin: 9999999999,
          status: 2
        )
        expect(game.valid?).to be_truthy
      end
    end
  end
end

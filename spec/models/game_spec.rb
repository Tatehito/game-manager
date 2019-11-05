require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do

    context 'required' do
      before do
        @user = FactoryBot.create(:user)
      end

      it "is valid with a user_id, asin, and status" do
        game = @user.games.new(asin: 1, status: 1)
        expect(game).to be_valid
      end

      it "is invalid without an asin" do
        game = @user.games.new(asin: nil, status: 1)
        game.valid?
        expect(game.errors[:asin]).to include("can't be blank")
      end

      it "is invalid without a status" do
        game = @user.games.new(asin: 1, status: nil)
        game.valid?
        expect(game.errors[:status]).to include("can't be blank")
      end
    end

    context 'duplicate errors' do
      before do
        @user = User.create(
          provider: "Twitter",
          uid: "1",
          user_name: "tatehito"
        )
        @user.games.create(asin: 1, status: 1)

        @user2 = User.create(
          provider: "Twitter",
          uid: "2",
          user_name: "tatehito"
        )
      end

      it "is invalid with a duplicate user_id and asin" do
        game = @user.games.new(asin: 1,status: 2)
        game.valid?
        expect(game.errors[:user_id]).to include("has already been taken")
      end

      it "is valid with a diffent user_id and a same asin" do
        game = @user2.games.new(asin: 1,status: 2)
        game.valid?
        expect(game.valid?).to be_truthy
      end

      it "is valid with a diffent asin and a same user_id" do
        game = @user.games.new(asin: 2,status: 2)
        expect(game.valid?).to be_truthy
      end
    end
  end
end

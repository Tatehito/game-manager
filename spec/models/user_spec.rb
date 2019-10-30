require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it "is valid with a provider, uid, and user_name" do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "is invalid without a provider" do
      user = FactoryBot.build(:user, provider: nil)
      user.valid?
      expect(user.errors[:provider]).to include("can't be blank")
    end

    it "is invalid without a uid" do
      user = FactoryBot.build(:user, uid: nil)
      user.valid?
      expect(user.errors[:uid]).to include("can't be blank")
    end

    it "is invalid without a user_name" do
      user = FactoryBot.build(:user, user_name: nil)
      user.valid?
      expect(user.errors[:user_name]).to include("can't be blank")
    end

    context 'duplicate errors' do
      before do
        FactoryBot.create(:user)
      end

      it "is invalid with a duplicate provider and uid" do
        user = FactoryBot.build(:user, user_name: "Taro")
        user.valid?
        expect(user.errors[:provider]).to include("has already been taken")
      end

      it "is valid with a diffent provider and a same uid" do
        user = FactoryBot.build(:user, provider: "Facebook")
        expect(user.valid?).to be_truthy
      end

      it "is valid with a same provider and a diffent uid" do
        user = FactoryBot.build(:user, uid: "987654321")
        expect(user.valid?).to be_truthy
      end
    end
  end
end

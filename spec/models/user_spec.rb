require 'rails_helper'

RSpec.describe User, type: :model do

  # validation
  it "is valid with a provider, uid, and user_name" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # it "is invalid without a provider" do
  #   user = User.new(provider: nil)
  #   user.valid?
  #   expect(user.errors[:provider]).to include("can't be blank")
  # end

  # it "is invalid without a uid" do
  #   user = User.new(uid: nil)
  #   user.valid?
  #   expect(user.errors[:uid]).to include("can't be blank")
  # end

  # it "is invalid without a user_name" do
  #   user = User.new(user_name: nil)
  #   user.valid?
  #   expect(user.errors[:user_name]).to include("can't be blank")
  # end

  # it "is invalid with a duplicate provider and uid" do
  #   User.create(
  #     provider: "Twitter",
  #     uid: "123456789",
  #     user_name: "tatehito",
  #   )

  #   user = User.new(
  #     provider: "Twitter",
  #     uid: "123456789",
  #     user_name: "joker",
  #   )

  #   user.valid?
  #   expect(user.errors[:provider]).to include("has already been taken")
  #   expect(user.errors[:uid]).to include("has already been taken")
  # end

  # it "is valid with a diffent provider and a same uid" do
  # end

  # it "is valid with a same provider and a diffent uid" do
  # end

end

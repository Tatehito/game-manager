class User < ApplicationRecord
  validates :provider, :uid, :user_name, presence: true
  validates :provider, uniqueness: { scope: :uid }
  has_many :games, :dependent => :destroy

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    screen_name = auth[:extra][:raw_info][:screen_name]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image].gsub(/_normal.jpg/, ".jpg")

    self.find_or_create_by(provider: provider, uid: uid) do |user|
        user.user_name = user_name
        user.image_url = image_url
        user.screen_name = screen_name
    end
  end
end

class User < ApplicationRecord
  validates :provider, :uid, :user_name, presence: true
  validates :provider, uniqueness: { scope: :uid }

  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    user_name = auth[:info][:name]
    image_url = auth[:info][:image]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
        user.user_name = user_name
        user.image_url = image_url
    end
end
end

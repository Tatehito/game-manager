class User < ApplicationRecord
  validates :provider, :uid, :user_name, presence: true
  validates :provider, uniqueness: { scope: :uid }
end

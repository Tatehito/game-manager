class Game < ApplicationRecord
  validates :user_id, :asin, :status, presence: true
  validates :user_id, uniqueness: { scope: :asin }
  belongs_to :user
end

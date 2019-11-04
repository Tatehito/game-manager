class Game < ApplicationRecord
  validates :uid, :asin, :status, presence: true
  validates :uid, uniqueness: { scope: :asin }
end

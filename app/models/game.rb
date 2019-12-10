class Game < ApplicationRecord
  validates :user_id, :asin, :status, presence: true
  belongs_to :user
end

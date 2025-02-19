class Story < ApplicationRecord
  belongs_to :user
  validate :image, presence: true 
  validates :body, length: { maximum: 500 }
end

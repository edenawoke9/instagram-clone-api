class Story < ApplicationRecord
  belongs_to :user
  validates :image, presence: true


  validates :body, length: { maximum: 500 }
end

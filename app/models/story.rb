class Story < ApplicationRecord
  belongs_to :user
  validates :image, presence: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']


  validates :body, length: { maximum: 500 }
end

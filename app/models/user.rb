class User < ApplicationRecord
  has_many :posts
  has_many :stories
  has_many :comments
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'receiver_id'
  
  
  has_many :followers, class_name: 'Follow', foreign_key: 'following_id'
  has_many :following, class_name: 'Follow', foreign_key: 'follower_id'

  
  after_create :send_welcome_email

 
  has_secure_password


  validates :email, uniqueness: true
  validates :password, presence: true
  validate :at_least_one_contact_info

  private

  def at_least_one_contact_info
    if email.blank? && phonenumber.blank? && username.blank?
      errors.add(:base, "At least one of email, phone number, or username must be present")
    end
  end

  def send_welcome_email
    # TODO: Implement email sending logic
  end
end

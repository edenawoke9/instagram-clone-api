class User < ApplicationRecord
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
  end
  
class User < ApplicationRecord
    # has_secure_password
    # has_many :posts 
    has_secure_password(validations: false)
    validates :first_name, presence: true, presence: true
    validates :username, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :role, presence: true
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
end

class Chef < ApplicationRecord
    before_save {self.email = email.downcase}
    validates :name,presence:true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,presence:true,length:{maximum:255},
                    format: {with:VALID_EMAIL_REGEX},
                    uniqueness:{case_sensitive:false}
    has_many :recipes,dependent: :destroy
    has_secure_password
    validates :password,presence: true,allow_nil: true
    has_many :comments, dependent: :destroy
    has_many :messages, dependent: :destroy
end
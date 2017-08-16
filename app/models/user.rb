class User < ApplicationRecord
    has_many :microposts
    before_save { self.email = email.downcase}
    validates :name, presence:true, length: {maximum:50}
    validates :email, presence:true, length: {maximum:255},uniqueness:{case_sensitive: false}
    # validates :email, format: { with: /<regular expression>/}
    # 邮箱验证的正则：VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, format: { with: VALID_EMAIL_REGEX}

    has_secure_password
    validates :password, presence:true, length:{minimum:6}
end

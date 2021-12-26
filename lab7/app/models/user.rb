# Сущность "Пользователь" (студент)
class User < ApplicationRecord
  has_many :laboratory_works
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, length: { maximum: 150 }
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

  def to_s
    email
  end
end

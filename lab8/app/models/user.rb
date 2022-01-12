class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :lab_reports, dependent: :destroy

  validates :first_name, presence: true, length: {maximum: 100}
  validates :last_name, presence: true, length: {maximum: 100}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

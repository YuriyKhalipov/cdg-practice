# Сущность "Лабораторная работа"
class LaboratoryWork < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true, length: { maximum: 500 }
  validates :mark, allow_nil: true, format: { with: /[A-F]/ }
end

class LabReport < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {maximum: 250}
  validates :description, presence: true, length: {maximum: 500}
  validates :grade, allow_nil: true, format: { with: /\b([1-9]|[1-9][0-9]|100)\b/ },  numericality: { only_integer: true }
end


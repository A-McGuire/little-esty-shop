class BulkDiscount < ApplicationRecord
  validates :threshold, presence: true
  validates :discount, presence: true, numericality: true, inclusion: {in: 0..1.0}
  belongs_to :merchant
end
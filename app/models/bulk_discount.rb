class BulkDiscount < ApplicationRecord
  validates :threshold, presence: true
  validates :discount, presence: true, numericality: true 
  belongs_to :merchant
end
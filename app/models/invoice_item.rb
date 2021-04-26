class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  enum status: [ :packaged, :pending, :shipped ]

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item
  has_many :bulk_discounts, through: :merchant

  def best_discount
    # binding.pry
    # bulk_discounts.order(threshold: :desc).where("threshold <= ?", self.quantity)
    bulk_discounts.order(threshold: :desc).where("threshold <= ?", self.quantity).first.discount
  end
end
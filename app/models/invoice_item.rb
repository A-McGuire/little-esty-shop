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
    bulk_discounts.order(:discount)
    .where("threshold <= ?", self.quantity)
    .last
  end
  
  def revenue
    if best_discount.present?
      quantity * unit_price * (1 - best_discount.discount)
    else
      quantity * unit_price
    end
  end
end
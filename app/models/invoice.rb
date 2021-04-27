class Invoice < ApplicationRecord
  validates :status, presence: true
  enum status: [ 'in progress', 'cancelled', 'completed' ]

  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  def self.find_all_invoices_not_shipped
    joins(:invoice_items)
    .where.not("invoice_items.status = ?", 2)
    .order(created_at: :desc)
    .distinct
  end

  def invoice_items_info(merchant_id)
    InvoiceItem.joins(item: :merchant)
               .where(invoice_id: self.id)
               .where('merchants.id = ?', merchant_id)
               .select("invoice_items.*, items.name")
  end

  def expected_revenue(merchant_id)
    InvoiceItem.joins(item: :merchant)
               .where(invoice_id: self.id)
               .group(:invoice_id)
               .where('merchants.id = ?', merchant_id)
               .sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def item_sell_info
    self.invoice_items.includes(:item)
  end

  def revenue
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def apply_bulk_discounts
    invoice_items.sum do |invoice_item|
      invoice_item.revenue
    end
  end

  #   invoice_items.joins(:bulk_discounts)
  #                .where("invoice_items.quantity >= bulk_discounts.threshold")
  #                .select("invoice_items.*, max(invoice_items.quantity * invoice_items.unit_price * (1 - bulk_discounts.discount)) as total_revenue")
  #                .group("invoice_items.id")
  #                .order(total_revenue: :desc)
  # end
end

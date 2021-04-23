# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

merchant1 = Merchant.find(1)
merchant2 = Merchant.find(2)
merchant3 = Merchant.find(3)

bulk_discount1 = merchant1.bulk_discounts.create!(threshold: 5, discount: 0.1)
bulk_discount2 = merchant1.bulk_discounts.create!(threshold: 10, discount: 0.2)
bulk_discount3 = merchant1.bulk_discounts.create!(threshold: 15, discount: 0.3)

bulk_discount4 = merchant2.bulk_discounts.create!(threshold: 5, discount: 0.1)
bulk_discount5 = merchant2.bulk_discounts.create!(threshold: 10, discount: 0.2)
bulk_discount6 = merchant2.bulk_discounts.create!(threshold: 15, discount: 0.3)

bulk_discount7 = merchant3.bulk_discounts.create!(threshold: 5, discount: 0.1)
bulk_discount8 = merchant3.bulk_discounts.create!(threshold: 10, discount: 0.2)
bulk_discount9 = merchant3.bulk_discounts.create!(threshold: 15, discount: 0.3)
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
services = [
  { name: 'Service One', price: 100, commission: 10.0 },
  { name: 'Service Two', price: 200, commission: 15.0 },
  { name: 'Service Three', price: 300, commission: 20.0 },
  { name: 'Service Four', price: 400, commission: 25.0 },
  { name: 'Service Five', price: 500, commission: 30.0 }
]

inventories = [
  { name: 'Dreads', price: 1000, bought: true, supplied: false, in_stock: 200, supplier_name: 'Austin'},
  { name: 'Dreads 1', price: 1000, bought: true, supplied: false, in_stock: 200, supplier_name: 'Austin'},
  { name: 'Dreads 2', price: 1000, bought: true, supplied: false, in_stock: 200, supplier_name: 'Austin'},
  { name: 'Dreads 3', price: 1000, bought: true, supplied: false, in_stock: 200, supplier_name: 'Austin'},
  { name: 'Dreads 4', price: 1000, bought: true, supplied: false, in_stock: 200, supplier_name: 'Austin'},
]

services.each do |service_attrs|
  Service.create(service_attrs)
end

inventories.each do |inventory_attrs|
  Inventory.create(inventory_attrs)
end

puts "Created #{Inventory.count} services"
puts "Created #{Service.count} services"

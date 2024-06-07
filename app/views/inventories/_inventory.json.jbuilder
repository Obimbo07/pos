json.extract! inventory, :id, :name, :price, :bought, :supplied, :supplier_name, :in_stock, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)

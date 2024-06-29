class Inventory < ApplicationRecord
  has_and_belongs_to_many :booking_histories
    def self.ransackable_attributes(auth_object = nil)
      ["bought", "created_at", "id", "id_value", "in_stock", "name", "price", "supplied", "supplier_name", "updated_at"]
    end

    def self.ransackable_associations(auth_object = nil)
      ["booking_histories"]
    end
    
    def in_stock_status
        in_stock.nil? ? "out-of-stock" : in_stock
    end
    def decrement_stock
        if in_stock > 0
          self.in_stock -= 1
          save!
        else
          raise "Stock not available"
       end
    end
end
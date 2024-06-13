class Inventory < ApplicationRecord
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
class Inventory < ApplicationRecord
    def in_stock_status
        in_stock.nil? ? "out-of-stock" : in_stock
    end
    def decrement_stock
        self.in_stock -= 1
        save!
    end
end
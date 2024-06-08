class Service < ApplicationRecord
  has_many :workers
  has_and_belongs_to_many :workers
end

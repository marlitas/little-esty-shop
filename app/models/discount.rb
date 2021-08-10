class Discount < ApplicationRecord
  belongs_to :merchant
  validates :percent, presence:true
  validates :quantity_threshold, presence:true
end

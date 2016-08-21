class Item < ApplicationRecord
  belongs_to :category
  belongs_to :seller
  belongs_to :status
end

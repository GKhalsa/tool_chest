class Tool < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :name,     presence: true
  validates :price,    presence: true
  validates :quantity, presence: true
end

class Fuel < ActiveRecord::Base
  enum status: [:active, :inactive]

  validates :name, presence: true

  has_many :prices
end

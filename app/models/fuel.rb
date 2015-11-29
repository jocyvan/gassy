class Fuel < ActiveRecord::Base
  enum status: [:active, :inactive]

  validates :name, :status, presence: true

  has_many :prices, dependent: :destroy
  has_many :stations, through: :prices
end

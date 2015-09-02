class Fuel < ActiveRecord::Base
  enum status: [:active, :inactive]

  validates :name, presence: true
end

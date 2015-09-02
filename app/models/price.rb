class Price < ActiveRecord::Base
  belongs_to :fuel
  belongs_to :station

  scope :uniq_prices, -> { select("DISTINCT ON (prices.fuel_id) prices.*").order("fuel_id, created_at DESC") }

  delegate :name, to: :station, prefix: true
  delegate :name, to: :fuel, prefix: true
end

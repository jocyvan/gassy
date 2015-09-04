class Price < ActiveRecord::Base
  attr_accessor :maskared_value

  belongs_to :fuel
  belongs_to :station

  scope :uniq_prices, -> { select("DISTINCT ON (prices.fuel_id) prices.*").order("fuel_id, created_at DESC") }

  delegate :name, to: :station, prefix: true
  delegate :name, to: :fuel, prefix: true


  def maskared_value=(value)
    self.value = value.gsub(',', '.')
  end
end

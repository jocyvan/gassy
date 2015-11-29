class Price < ActiveRecord::Base
  attr_accessor :masked_value

  validates :fuel_id, :station_id, :value, presence: true
  validates :value, numericality: { greater_than: 0 }

  belongs_to :fuel, counter_cache: true
  belongs_to :station

  scope :uniq_prices, -> { select("DISTINCT(prices.fuel_id), prices.*").order("fuel_id, created_at DESC") }

  delegate :name, :user_id, to: :station, prefix: true
  delegate :name, to: :fuel, prefix: true

  def masked_value=(value)
    self.value = value.gsub(',', '.')
  end
end

class Station < ActiveRecord::Base
  is_impressionable
  paginates_per 10

  validates :name, :city, presence: true
  
  belongs_to :user
  has_many :prices
  has_many :rates
  has_many :comments
end

class Station < ActiveRecord::Base
  paginates_per 10

  validates :name, :city, presence: true
  
  belongs_to :user
  has_many :rates
end

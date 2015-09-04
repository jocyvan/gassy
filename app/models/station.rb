class Station < ActiveRecord::Base
  is_impressionable
  paginates_per 10

  validates :name, :city, presence: true
  
  belongs_to :user
  has_many :prices, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
end

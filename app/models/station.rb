class Station < ActiveRecord::Base
  is_impressionable
  paginates_per 10

  validates :name, :city, presence: true

  belongs_to :user
  has_many :prices, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user
end

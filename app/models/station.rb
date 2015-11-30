class Station < ActiveRecord::Base
  is_impressionable
  paginates_per 10

  validates :name, :city, presence: true
  validates :user_id, presence: true, on: :create

  belongs_to :user

  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user

  has_many :prices, dependent: :destroy
  has_many :fuels, through: :prices

  delegate :name, to: :user, prefix: true
end

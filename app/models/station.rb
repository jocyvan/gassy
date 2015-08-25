class Station < ActiveRecord::Base
  belongs_to :user

  validates :name, :city, presence: true
end

class Rate < ActiveRecord::Base
  enum status: [:like, :unlike]

  belongs_to :station
  belongs_to :user
end

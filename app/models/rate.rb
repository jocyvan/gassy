class Rate < ActiveRecord::Base
  enum status: [:like, :unlike]

  belongs_to :station, counter_cache: true
  belongs_to :user
end

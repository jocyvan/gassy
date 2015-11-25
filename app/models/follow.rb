class Follow < ActiveRecord::Base
  validates :user_id, :station_id, presence: true

  belongs_to :user
  belongs_to :station, counter_cache: true
end

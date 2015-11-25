class Rate < ActiveRecord::Base
  enum status: [:like, :unlike]

  validates :user_id, :station_id, presence: true

  belongs_to :user
  belongs_to :station, counter_cache: true

  scope :this_month, -> { where(created_at: Date.today.at_beginning_of_month..Date.today.at_end_of_month) }
  scope :prev_month, -> { where(created_at: Date.today.prev_month.at_beginning_of_month..Date.today.prev_month.at_end_of_month) }
  scope :prev_2_month, -> { where(created_at: Date.today.prev_month.prev_month.at_beginning_of_month..Date.today.prev_month.prev_month.at_end_of_month) }
end

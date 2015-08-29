class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :station, counter_cache: true

  validates :name, presence: true, if: "user.nil?"
  validates :content, presence: true

  delegate :name, to: :user, prefix: true
end

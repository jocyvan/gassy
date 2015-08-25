class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_destroy :clear_user

  enum role: [:user, :admin]

  validates :name, :email, :password, :password_confirmation, presence: true, on: :create
  validates :name, :email, presence: true, on: :update
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "is not an email" }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :stations

  protected

  def clear_user
    self.stations.update_all(user_id: nil)
  end
end

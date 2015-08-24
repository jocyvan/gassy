class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  enum role: [:user, :admin]

  validates :name, :email, :password, :password_confirmation, presence: true, on: :create
  validates :name, :email, presence: true, on: :update
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "is not an email" }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :stations
end

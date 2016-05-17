class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  enum role: [:user, :admin]

  validates :name, :email, :password, :password_confirmation, presence: true, on: :create
  validates :name, :email, presence: true, on: :update
  validates :email, uniqueness: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/, message: "is not an email" }

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :stations, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  has_many :follows, dependent: :destroy
  has_many :followed_stations, through: :follows, source: :station

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      password_gen = Devise.friendly_token[0,12]
      user.email = auth.info.email
      user.password = password_gen
      user.password_confirmation = password_gen
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end

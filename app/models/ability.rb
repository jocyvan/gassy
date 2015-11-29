class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      if user.admin?
        can :manage, :all

        cannot :destroy, Fuel do |fuel|
          fuel.prices.size > 0
        end
      else
        can [:show, :update], User, id: user.id

        # STATIONS
        can :manage, Station, user_id: user.id
        cannot :index, Station

        # RATES
        can [:like, :unlike, :follow], Station

        # PRICES
        can :manage, Price do |price|
          price.station_user_id == user.id
        end
      end
    end
    can :show, Station
  end
end

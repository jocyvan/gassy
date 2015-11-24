class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.persisted?
      if user.admin?
        can :manage, :all
      else
        can [:show, :update], User, id: user.id

        # STATIONS
        can :manage, Station, user_id: user.id
        cannot :index, Station

        # PRICES
        can :manage, Price, station_user_id: user.id

        # RATES
        can [:like, :unlike, :follow], Station
      end
    end
    can :show, Station

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

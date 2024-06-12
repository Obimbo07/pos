# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user, session)
    if user.is_a?(Admin)
      can :manage, :all
    elsif user.is_a?(Worker)
      can :read, Inventory
      can :read, Service
      can :create, BookingHistory
      can :read, BookingHistory
      can :update, BookingHistory, worker_id: user.id
      can :read, Worker, id: user.id
      can :update, Worker, id: user.id
    elsif session[:user_id]
      # Define abilities for session-based users
      can :read, Inventory
      can :read, Service
    else
      can :read, :all
    end

    # Common abilities for all users
    can :read, :home
  end
end

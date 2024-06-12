class ApplicationController < ActionController::Base
  before_action :set_current_ability

  private

  def current_user
    current_worker || current_admin
  end

  def set_current_ability
    @current_ability ||= Ability.new(current_user, session)
  end
end

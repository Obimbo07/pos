class ApplicationController < ActionController::Base
    before_action :authenticate_worker!
end

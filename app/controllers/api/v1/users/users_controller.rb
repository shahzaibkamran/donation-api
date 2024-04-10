module Api
  module V1
    module Users
      class UsersController < ApplicationController
        skip_before_action :doorkeeper_authorize!, only: [:validate_email]

      end
    end
  end
end
module Api
  module V1
    module Users
      class AuthController < ApplicationController
        skip_before_action :doorkeeper_authorize!, except: [:logout]

        def register
          auth_service = Auth::AuthService.new(user_params)
          response = auth_service.register
          binding.pry
          render json: response
          # respond_with_json(response, response[:status])
        end

        def auth
          auth_service = Auth::AuthService.new(user_params)
          response = auth_service.authenticate
          respond_with_json(response, response[:status])
        end

        def logout
          # auth_service = Auth::AuthService.new(user_params, active_user)
          # response = auth_service.logout
          # respond_with_json(response, response[:status])
        end

        def user_params
          params.permit(:email, :password, :first_name, :last_name)
        end

      end
    end
  end
end
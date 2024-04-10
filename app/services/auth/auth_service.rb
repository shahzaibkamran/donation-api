module Auth
  class AuthService

    attr_reader :params, :user

    def initialize(params = nil, user = nil)
      @params = params
      @user = user
    end

    def register
      user = User.find_by(email: params['email'])
      if user.present?
        { error: 'Email already registered', status: :bad_request }
      else
        new_user = User.new(params)
        if new_user.save
          get_response_with_token(new_user,1000)
        else
          { error: new_user.errors.full_messages, status: :bad_request }
        end
      end
    end

    def authenticate
      user = User.find_for_authentication(email: params[:email])
      if user&.valid_password?(params[:password]) 
        access_token = Doorkeeper::AccessToken.create(
          resource_owner_id: user.id,
          expires_in: 1000.hours,
          application_id: 1
        )
        return { user: UserSerializer.new(user), access_token: access_token.token, status: :ok }
      end
      { error: 'Email or Password incorrect', status: :bad_request } 
    end

    private

    def get_response_with_token(user,duration)
      access_token = Doorkeeper::AccessToken.create(
        resource_owner_id: user.id,
        expires_in: duration.hours,
        application_id: 1
      )
      { user: user, access_token: access_token.token, status: :ok }
    end

  end
end
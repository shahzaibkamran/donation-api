# frozen_string_literal: true

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (requires ORM extensions installed).
  # Check the list of supported ORMs here: https://github.com/doorkeeper-gem/doorkeeper#orms
  orm :active_record
  grant_flows %w[password]
  access_token_generator '::Doorkeeper::JWT'
  resource_owner_from_credentials do |_routes|
    User.authenticate(params[:email], params[:password])
  end

  Doorkeeper::JWT.configure do
    token_payload do |opts|
      user = User.find(opts[:resource_owner_id])
      {
        sub: user.id,
        name:user.first_name,
        iat: Time.current.utc.to_i
      }
    end
  
    use_application_secret false
    secret_key Rails.application.credentials.jwt_secret_key!
    encryption_method :hs512
  end
  
  use_refresh_token

  allow_blank_redirect_uri true

  skip_authorization do
     true
  end

end

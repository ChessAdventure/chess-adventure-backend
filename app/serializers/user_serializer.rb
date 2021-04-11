class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :api_key, :username
end

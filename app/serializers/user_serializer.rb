class UserSerializer
  include JSONAPI::Serializer
  attributes :api_key, :username
end

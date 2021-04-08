#config/initializers/session_store.rb
if Rails.env === 'production' 
  Rails.application.config.session_store :cookie_store, key: '_chess-adventure', domain: 'chess-adventure-json-api'
else
Rails.application.config.session_store :cookie_store, key: '_chess-adventure'
end
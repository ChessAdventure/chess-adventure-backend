module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected
    def find_verified_user
      puts "ENCRYPTED COOKIES: #{cookies.encrypted}"
      puts "user id? #{cookies.encrypted[:user_id]}"
      puts "params? #{params[:token]}"
    end
  end
end

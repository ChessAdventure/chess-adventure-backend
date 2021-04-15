module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user_id

    def connect
      self.user_id = find_id
    end

    private

    def find_id
      binding.pry
    end
  end
end

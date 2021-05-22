module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_chef

    def connect
      self.current_chef = find_current_user
    end

    def disconnect
    end

    protected
      def find_current_user
        # puts 'oh hello there...........................'
        # puts cookies.signed[:chef_id]
        # # puts current_chef
        # puts "ohhh the bug............................."
        Chef.find_by(id: cookies.signed[:chef_id])
      end
  end
end

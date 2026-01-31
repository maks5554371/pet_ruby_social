module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      Rails.logger.info "✅ WebSocket connected for user: #{current_user.id}"
    rescue => e
      Rails.logger.error "❌ WebSocket connection failed: #{e.message}"
      reject_unauthorized_connection
    end

    private

    def find_verified_user
      # Для Devise
      if env['warden']&.user
        env['warden'].user
      else
        Rails.logger.error "❌ No warden user found"
        reject_unauthorized_connection
      end
    end
  end
end

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  # После создания сообщения, отправляем его через WebSocket
  after_create_commit { broadcast_message }

  private

  def broadcast_message
    # Отправляем сообщение в канал ConversationChannel
    ActionCable.server.broadcast(
      "conversation_#{conversation_id}",
      {
        message: render_message,
        conversation_id: conversation_id
      }
    )
  end

  def render_message
    # Рендерим HTML для сообщения
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: self }
    )
  end
end

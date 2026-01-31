# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @conversation = current_user.conversations.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      # Отправляем через WebSocket
      ActionCable.server.broadcast(
        "conversation_#{@conversation.id}",
        {
          message_html: render_to_string(
            partial: 'messages/message',
            locals: { message: @message, current_user_id: nil }
          ),
          user_id: @message.user_id,
          conversation_id: @conversation.id
        }
      )

      head :ok
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end

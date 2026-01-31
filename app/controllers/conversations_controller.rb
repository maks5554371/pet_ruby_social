# app/controllers/conversations_controller.rb
class ConversationsController < ApplicationController
  before_action :authenticate_user!

  # GET /conversations
  # Показывает список всех бесед пользователя
  def index
    @conversations = current_user.conversations
                                 .includes(:messages, :sender, :recipient)
                                 .order('messages.created_at DESC')
  end

  # GET /conversations/:id
  # Показывает конкретную беседу с сообщениями
  def show
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages.includes(:user).order(created_at: :asc)
    @message = Message.new

    # Отмечаем сообщения как прочитанные
    mark_as_read
  end

  # POST /conversations
  # Создаёт новую беседу или находит существующую
  def create
    recipient = User.find(params[:recipient_id])

    # Ищем существующую беседу между пользователями
    @conversation = Conversation.between(current_user.id, recipient.id).first

    # Если беседы нет, создаём новую
    @conversation ||= Conversation.create!(
      sender_id: current_user.id,
      recipient_id: recipient.id
    )

    redirect_to conversation_path(@conversation)
  end

  private

  def mark_as_read
    @conversation.messages
                 .where.not(user: current_user)
                 .where(read: false)
                 .update_all(read: true)
  end
end

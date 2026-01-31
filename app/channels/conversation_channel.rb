class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation_id])

    if conversation.sender_id == current_user.id || conversation.recipient_id == current_user.id
      stream_from "conversation_#{params[:conversation_id]}"
      Rails.logger.info "#{current_user.id} подписался на эту залупу #{params[:conversation_id]}"
    else
      reject
      Rails.logger.warn "#{current_user.id} попытка не пытка #{params[:conversation_id]}"
    end
  end

  def unsubscribed
    Rails.logger.info "#{current_user.id} отписался от этой залупы #{params[:conversation_id]}"
    stop_all_streams
  end
end

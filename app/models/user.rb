class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Беседы, которые я начал
  has_many :sent_conversations,
           class_name: "Conversation",
           foreign_key: "sender_id",
           dependent: :destroy

  # Беседы, которые начали со мной
  has_many :received_conversations,
           class_name: "Conversation",
           foreign_key: "recipient_id",
           dependent: :destroy

  # Все мои сообщения
  has_many :messages, dependent: :destroy

  # Метод для получения всех бесед пользователя
  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", id, id)
  end
end

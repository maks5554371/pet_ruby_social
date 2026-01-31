class Conversation < ApplicationRecord
  # Отправитель беседы
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  # Получатель беседы
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  # Все сообщения в беседе
  has_many :messages, dependent: :destroy

  # Валидация: пользователь не может создать беседу с самим собой
  validates :sender_id, uniqueness: { scope: :recipient_id }
  validate :not_self_conversation

  # Метод для получения собеседника (другого пользователя)
  def interlocutor(current_user)
    sender == current_user ? recipient : sender
  end

  # Последнее сообщение в беседе
  def last_message
    messages.order(created_at: :desc).first
  end

  private

  def not_self_conversation
    if sender_id == recipient_id
      errors.add(:base, "Нельзя создать беседу с самим собой")
    end
  end

  scope :between, ->(sender_id, recipient_id) {
    where(
      "(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)",
      sender_id, recipient_id, recipient_id, sender_id
    )
  }
end

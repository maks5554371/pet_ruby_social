class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false

      t.timestamps
    end

    # Индексы для быстрого поиска
    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
    # Индекс для поиска беседы между двумя пользователями
    add_index :conversations, [:sender_id, :recipient_id], unique: true
  end
end

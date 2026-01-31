import consumer from "./consumer";

window.subscribeToConversation = function (conversationId, currentUserId) {
  if (window.conversationSubscription) {
    window.conversationSubscription.unsubscribe();
  }

  window.currentUserId = currentUserId;

  window.conversationSubscription = consumer.subscriptions.create(
    {
      channel: "ConversationChannel",
      conversation_id: conversationId,
    },
    {
      received(data) {
        const messagesContainer = document.getElementById("messages");

        const isMine = data.user_id === window.currentUserId;

        const temp = document.createElement("div");
        temp.innerHTML = data.message_html;
        const messageElement = temp.querySelector(".message-item");

        if (isMine) {
          messageElement.classList.remove("justify-start");
          messageElement.classList.add("justify-end");

          const bubble = messageElement.querySelector(".message-bubble");
          if (bubble) {
            bubble.classList.remove("bg-white", "text-gray-800");
            bubble.classList.add("bg-blue-500", "text-white");
          }

          const time = messageElement.querySelector(".message-time");
          if (time) {
            time.classList.remove("text-gray-500");
            time.classList.add("text-blue-100");
          }

          const senderName = messageElement.querySelector(".sender-name");
          if (senderName) {
            senderName.remove();
          }
        } else {
          messageElement.classList.remove("justify-end");
          messageElement.classList.add("justify-start");
        }

        messagesContainer.appendChild(messageElement);
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      },
    },
  );
};

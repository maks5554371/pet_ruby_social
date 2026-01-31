// app/javascript/controllers/message_form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "submit"];
  static values = {
    currentUserId: Number,
  };

  async submit(event) {
    event.preventDefault();

    const form = event.target;
    const formData = new FormData(form);
    const body = formData.get("message[body]").trim();

    if (!body) return;

    // Отключаем кнопку на время отправки
    this.submitTarget.disabled = true;

    try {
      const response = await fetch(form.action, {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
          Accept: "application/json",
        },
        body: formData,
      });

      if (response.ok) {
        // Очищаем форму
        this.inputTarget.value = "";
        this.inputTarget.style.height = "auto";

        // Сообщение появится через WebSocket автоматически!
      } else {
        console.error("❌ Ошибка отправки сообщения");
        alert("Ошибка отправки сообщения");
      }
    } catch (error) {
      console.error("❌ Ошибка:", error);
      alert("Ошибка соединения");
    } finally {
      // Включаем кнопку обратно
      this.submitTarget.disabled = false;
    }
  }

  handleKeydown(event) {
    if ((event.ctrlKey || event.metaKey) && event.key === "Enter") {
      event.preventDefault();
      this.submitTarget.click();
    }
  }

  connect() {
    // Автоматическое изменение высоты textarea
    this.inputTarget.addEventListener("input", () => {
      this.inputTarget.style.height = "auto";
      this.inputTarget.style.height = this.inputTarget.scrollHeight + "px";
    });
  }
}

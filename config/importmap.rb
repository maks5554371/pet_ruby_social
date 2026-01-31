# config/importmap.rb
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Для inline скриптов нужен только ActionCable
pin "@rails/actioncable", to: "actioncable.esm.js"

# Закомментируйте эту строку:
# pin_all_from "app/javascript/channels", under: "channels"

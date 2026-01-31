// app/javascript/controllers/index.js
import { application } from "./application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import HelloController from "./hello_controller";
import MessageFormController from "./message_form_controller";

application.register("hello", HelloController);
application.register("message-form", MessageFormController);
eagerLoadControllersFrom("controllers", application);

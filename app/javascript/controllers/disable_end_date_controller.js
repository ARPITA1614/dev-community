
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="disable-end-date"
export default class extends Controller {
  connect() {
    this.disableEndDate()   //if replacinf form with validation erros then new form instance will render here so need to call it connect as well
  } // validation error aya tb bhi siable checked hoga 

  initialize() {
    this.element.setAttribute("data-action", "click->disable-end-date#disableEndDate")
  }

  disableEndDate() {
    const endDateElement = document.getElementById("work_experience_end_date")
    if (this.element.checked) {
      endDateElement.value = null
      endDateElement.setAttribute("disabled", "true")
    } else {
      endDateElement.removeAttribute("disabled")
    }
  }
}

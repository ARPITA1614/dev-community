import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bs-modal-form"
export default class extends Controller {

  connect() {
    console.log("I am connected!!!")
  }

  initialize() {
    this.element.setAttribute(
      "data-action",
      "click->bs-modal-form#showModal"
    )
  }

  showModal(event) {
    event.preventDefault()

    const url = this.element.getAttribute("href")

    fetch(url, {
      method: "GET",
      headers: {
        "Accept": "text/vnd.turbo-stream.html",
        "X-Requested-With": "XMLHttpRequest"
      },
      credentials: "same-origin"
    })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
  }
}

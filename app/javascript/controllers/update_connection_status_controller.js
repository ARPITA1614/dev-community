
import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="update-connection-status"
export default class extends Controller {
    connect() {
    }

    initialize() {
        this.element.setAttribute("data-action", "click->update-connection-status#updateConnectionStatus")
    }

    updateConnectionStatus() {
        event.preventDefault()
        this.url = this.element.getAttribute("href")   // url of event

        const connectionBody = new FormData()

        if (this.element.textContent === "Accept") {
            connectionBody.append("connection[status]", "accepted")
        } else if (this.element.textContent === "Reject") {
            connectionBody.append("connection[status]", "Rejected")
        }

        fetch(this.url, {   // fetch function to send this connection body to update action of connections controller
            method: "PATCH",
            headers: {
                Accept: "text/vnd.turbo-stream.html",
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute("content")
            },
            body: connectionBody
        })
            .then(response => response.text())      // will replace the updated element on DOM
            .then(html => Turbo.renderStreamMessage(html))
    }
}

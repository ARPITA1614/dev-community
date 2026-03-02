import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="connections"
export default class extends Controller {
  static targets=["connection"]
  connect() {
  }
  initialize(){   // enable our link to invoke function to send post request when user click on link using intialize function we will add event to link
    this.element.setAttribute("data-action", "click->connections#prepareConnectionParams")
  }
  prepareConnectionParams(){
    event.preventDefault()
    this.url=this.element.getAttribute("href")    // this line will give link that is attached to connect button link
    const element= this.connectionTarget   // define element using target attribute that we defined=>connection
    const requesterId=element.dataset.requesterId      // need to fetch requester and connector id using data attributes that we added on link
    const connectedId=element.dataset.connectedId 
    const connectionBody=new FormData   // initialize form data instance 
    // form data=> interface which provides way to construct set of key value pair representing form fields and their values which can be sent using fetch api
    connectionBody.append("connection[user_id]", requesterId )           // append params to form instance 
    connectionBody.append("connection[connected_user_id]", connectedId )   // user want to want
    connectionBody.append("connection[status]", "pending" )  
    // connection=> param name
    // fetch function to send form data to rails => call post api
    fetch(this.url, {
      method: "POST",
      headers: {            // key value pair
        Accept: "text/vnd.turbo-stream.html",   // what format post req to rails controller
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").getAttribute("content") // post patch delete must have csrf token in param
      },
       body: connectionBody   // need to pass body as param
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))   // after performing create action successfully we need to replace some content on DOM
    }
}

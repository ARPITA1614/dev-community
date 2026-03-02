import { Controller } from "@hotwired/stimulus"
// import { Modal } from "bootstrap" 
// used this controller when wehvae to show anything in bootstrap maodal
// Connects to data-controller="bs-modal"
export default class extends Controller {
  connect() {
    this.modal=new window.bootstrap.Modal(this.element, {   //intialize bootstrap modal
      keyboard: false
    })      //element=> dom element whwre data-controller="bs-modal"
    this.modal.show()  //open modal
  }
  disconnect(){
      this.modal.hide()
  }

  submitEnd(){   //for forms within bs modal hide after submit usethis method as datacation attr on submit button
     this.modal.hide()
  }
}

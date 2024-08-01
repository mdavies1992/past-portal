import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect(){
    console.log("Rest controller connected")
  }

  reset() {
    this.element.reset()
  }
}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="preview"
export default class extends Controller {
  static targets = ["title", "description", "price"];

  handleTitle(e) {
    this.titleTarget.innerText = e.target.value;
  }

  handleDescription(e) {
    this.descriptionTarget.innerText = e.target.value;
  }

  handlePrice(e) {
    const numberFormatter = new Intl.NumberFormat('en-US');

    this.priceTarget.innerText = numberFormatter.format(e.target.value);
  }
}

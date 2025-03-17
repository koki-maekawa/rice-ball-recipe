import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="step-forms"
export default class extends Controller {
  static targets = [ "stepFields", "addStepFormArea", "Template" ];
  connect() {
    this.updateStepNumbers();
  };

  addStepForm(event) {
    event?.preventDefault()
    const recordIndex = this.stepFieldsTargets.length;
    var content = this.TemplateTarget.innerHTML.replace(/RECORD/g, recordIndex);
    this.addStepFormAreaTarget.insertAdjacentHTML('beforebegin', content)
    this.updateStepNumbers();
  };
  
  removeForm(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = "true"
    item.style.display = 'none'
    this.updateStepNumbers();
  };

  updateStepNumbers() {
    this.stepFieldsTargets
      .filter(field => field.querySelector("input[name*='_destroy']")?.value !== "true")
      .forEach((field, index) => {
        field.querySelector("div").textContent = index + 1;
        field.querySelector("input[name*='step_number']").value = index + 1;
      });
  }
}

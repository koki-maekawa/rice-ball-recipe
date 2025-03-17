import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ingredient-forms"
export default class extends Controller {
  static targets = [ "ingredientFields", "addIngredientFormArea", "Template" ];
  connect() {
    this.addIngredientFormIfNoneExists();
  };

  addIngredientFormIfNoneExists() {
    if (this.ingredientFieldsTargets.filter(form => form.querySelector("input[name*='_destroy']").value === "false").length < 1) {
      this.addIngredientForm();
    }
  };

  addIngredientForm(event) {
    event?.preventDefault()
    const recordIndex = this.ingredientFieldsTargets.length;
    var content = this.TemplateTarget.innerHTML.replace(/RECORD/g, recordIndex);
    this.addIngredientFormAreaTarget.insertAdjacentHTML('beforebegin', content)
  };
  
  removeForm(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = "true"
    item.style.display =
     'none'  
    this.addIngredientFormIfNoneExists();
  };
}

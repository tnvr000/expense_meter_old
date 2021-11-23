// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['primaryCategory', 'category']
  connect() {
    let primaryCategoryId = this.primaryCategoryTarget.selectedOptions[0].value || 0;
    this.populateCategory(primaryCategoryId)
    console.log(this.primaryCategoryTarget);
  }

  changed() {
    let primaryCategoryId = this.primaryCategoryTarget.selectedOptions[0].value || 0;
    this.populateCategory(primaryCategoryId)
  }

  populateCategory(primaryCategoryId) {
    if(primaryCategoryId <= 0) {
      this.disableCategoryDropdown();
      return;
    }
    fetch(this.url(primaryCategoryId)).then((response) => {
      response.json().then((optionData) => {
        this.enableCategoryDropdown();
        this.categoryTarget.innerHTML = '';
        optionData.forEach(optionDatum => (this.createAndAppendOption(optionDatum)));
      });
    });
  }

  createAndAppendOption(optionDatum) {
    let option = document.createElement('option');
    option.innerHTML = optionDatum[0];
    option.value = optionDatum[1];
    this.categoryTarget.appendChild(option)
  }

  url(id) {
    return (`/primary_categories/${id}/categories`);
  }

  disableCategoryDropdown() {
    let categoryDropdownContainer = document.getElementById('category_container');
    categoryDropdownContainer.style.display = 'none';
    this.categoryTarget.innerHTML = ''
    this.categoryTarget.disabled = true;
  }

  enableCategoryDropdown() {
    let categoryDropdownContainer = document.getElementById('category_container');
    categoryDropdownContainer.style.display = 'block';
    this.categoryTarget.disabled = false;
  }
}

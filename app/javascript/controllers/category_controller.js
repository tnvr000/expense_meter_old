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
  static values = { 
    selectedPrimaryCategory: {type: Number, default: 0}, 
    selectedCategory: {type: Number, default: 0},
  }

  connect() {
    this.selectPrimaryCategory();
    this.populateCategory();
  }

  changed() {
    this.selectedPrimaryCategoryValue = this.primaryCategoryTarget.selectedOptions[0].value || 0;
    this.populateCategory();
  }

  populateCategory() {
    if(this.selectedPrimaryCategoryValue <= 0) {
      this.disableCategoryDropdown();
      return;
    }
    fetch(this.url(this.selectedPrimaryCategoryValue)).then((response) => {
      response.json().then((optionData) => {
        this.enableCategoryDropdown();
        this.categoryTarget.innerHTML = '';
        optionData.forEach(optionDatum => (this.createAndAppendOption(optionDatum)));
        this.selectCatgory();
      });
    });
  }

  createAndAppendOption(optionDatum) {
    let option = document.createElement('option');
    option.innerHTML = optionDatum.name;
    option.value = optionDatum.id;
    this.categoryTarget.appendChild(option);
  }

  url(id) {
    return (`/primary_categories/${id}/categories`);
  }

  disableCategoryDropdown() {
    let categoryDropdownContainer = document.getElementById('category_container');
    categoryDropdownContainer.style.display = 'none';
    this.categoryTarget.innerHTML = '';
    this.categoryTarget.disabled = true;
  }

  enableCategoryDropdown() {
    let categoryDropdownContainer = document.getElementById('category_container');
    categoryDropdownContainer.style.display = 'block';
    this.categoryTarget.disabled = false;
  }

  selectPrimaryCategory() {
    if(this.selectedPrimaryCategoryValue != 0) {
      this.primaryCategoryTarget.value = this.selectedPrimaryCategoryValue;
    }
  }

  selectCatgory() {
    if(this.selectedCategoryValue != 0) {
      this.categoryTarget.value = this.selectedCategoryValue;
      this.selectedCategoryValue = 0;
    }
  }
}

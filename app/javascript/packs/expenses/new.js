document.addEventListener('DOMContentLoaded', function() {
  let primaryCategoryId = document.getElementById('expense_primary_category').selectedOptions[0].value || 0;
  populateCategory(primaryCategoryId);
  console.log('DOM');
  let s = document.querySelector('#expense_primary_category');
  console.log(s);
  document.querySelector('#expense_primary_category').addEventListener('change', function(event) {
    let primaryCategoryId = event.target.selectedOptions[0].value || 0;
    console.log(primaryCategoryId);
    populateCategory(primaryCategoryId);
  })
})

function disableCategoryDropdown() {
  let categoryDropdownContainer = document.getElementById('category_container');
  let categoryDropdown = document.getElementById('expense_category_id')
  categoryDropdownContainer.style.display = 'none';
  categoryDropdown.innerHTML = ''
  categoryDropdown.disabled = true;
}

function enableCategoryDropdown() {
  let categoryDropdownContainer = document.getElementById('category_container');
  let categoryDropdown = document.getElementById('expense_category_id')
  categoryDropdownContainer.style.display = 'block';
  categoryDropdown.disabled = false;
}

function createAndAppendOption(optionDatum, categoryDropdown) {
  option = document.createElement('option');
  option.innerHTML = optionDatum[0];
  option.value = optionDatum[1];
  categoryDropdown.appendChild(option)
}

function populateCategory(primaryCategoryId) {
  if(primaryCategoryId <= 0) {
    disableCategoryDropdown();
    return;
  }
  fetch(url(primaryCategoryId)).then(function(response) {
    response.json().then(function(optionData) {
      enableCategoryDropdown();
      let categoryDropdown = document.getElementById('expense_category_id');
      categoryDropdown.innerHTML = '';
      optionData.forEach(optionDatum => (createAndAppendOption(optionDatum, categoryDropdown)));
    });
  });
}

function url(id) {
  return (`/primary_categories/${id}/categories`);
}

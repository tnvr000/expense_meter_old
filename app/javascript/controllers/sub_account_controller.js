import { Controller } from 'stimulus'

export default class extends Controller {
  // TODO: cash will be default sub-account for new expenses
  // TODO: autofill sub-account checkbox and sub-account amount text field as present in database
  // TODO: keep one sub-account amount textfield disabled that will complete remaingin amount
  // TODO: give option to select which sub-account amount textfield(which will be disabled)
  // is to be used to complete remaining amount
  static targets = ['cash', 'bank', 'ewallet']
  connect() {
    console.log(this.cashTarget)
    console.log(this.bankTargets)
    console.log(this.ewalletTargets)
  }

  enable_amount(event) {
    let amount_field = document.getElementById(event.params.id)
    if (event.target.checked) {
      amount_field.classList.remove('hidden')
      amount_field.disabled = false
    } else {
      amount_field.classList.add('hidden')
      amount_field.disabled = true
    }
  }
}

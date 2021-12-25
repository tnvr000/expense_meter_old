import { Controller } from 'stimulus'

export default class extends Controller {
  // TODO: cash will be default sub-account for new expenses
  // TODO: keep one sub-account amount textfield disabled that will complete remaingin amount
  // TODO: give option to select which sub-account amount textfield(which will be disabled)
  // is to be used to complete remaining amount
  static targets = ['useSubAccount']
  connect() {
    this.useSubAccountTargets.forEach(target => {
      if (target.checked) {
        this.enableAmountField(this.getAmountField(target))
      }
    });
  }

  enable_amount(event) {
    let amountField = document.getElementById(event.params.id)
    event.target.checked ? this.enableAmountField(amountField) : this.disableAmountField(amountField)
  }

  enableAmountField(amountField) {
    amountField.classList.remove('hidden')
    amountField.disabled = false
  }

  disableAmountField(amountField) {
    amountField.classList.add('hidden')
    amountField.disabled = false
  }

  getAmountField(subAccountField) {
    return document.getElementById(subAccountField.dataset.subAccountIdParam)
  }
}

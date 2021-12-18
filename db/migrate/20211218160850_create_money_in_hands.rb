class CreateMoneyInHands < ActiveRecord::Migration[6.1]
  def change
    create_table :money_in_hands do |t|
      t.references :account
      t.float :balance
      t.timestamps
    end
  end
end

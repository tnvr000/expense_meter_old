# frozen_string_literal: true

# create transactions table
class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :account
      t.references :transactionable, polymorphic: true
      t.float :amount
      t.float :balance
      t.string :description
      t.timestamps
    end
  end
end

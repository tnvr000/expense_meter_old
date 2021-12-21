# frozen_string_literal: true

# create expenditures table
class CreateExpenditures < ActiveRecord::Migration[6.1]
  def change
    create_table :expenditures do |t|
      t.references :expense
      t.references :expensable, polymorphic: true
      t.float :amount
      t.float :balance
      t.timestamps
    end
  end
end

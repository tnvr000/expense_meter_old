# frozen_string_literal: true

# create trades table
class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.references :account
      t.references :tradable, polymorphic: true
      t.float :amount
      t.float :balance
      t.string :description
      t.timestamps
    end
  end
end

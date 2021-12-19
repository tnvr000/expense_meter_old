# frozen_string_literal: true

# create ewallets table
class CreateEwallets < ActiveRecord::Migration[6.1]
  def change
    create_table :ewallets do |t|
      t.references :account
      t.string :name
      t.float :balance
      t.timestamps
    end
  end
end

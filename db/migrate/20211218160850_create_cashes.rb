# frozen_string_literal: true

# create cashes table
class CreateCashes < ActiveRecord::Migration[6.1]
  def change
    create_table :cashes do |t|
      t.references :account
      t.float :balance
      t.timestamps
    end
  end
end

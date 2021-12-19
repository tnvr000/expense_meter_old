# frozen_string_literal: true

# create banks table
class CreateBanks < ActiveRecord::Migration[6.1]
  def change
    create_table :banks do |t|
      t.references :account
      t.string :name
      t.float :balance
      t.timestamps
    end
  end
end

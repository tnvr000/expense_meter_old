# frozen_string_literal: true

# create profiles table in database
class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :customer
      t.string :name
      t.string :contact
      t.timestamps
    end
  end
end

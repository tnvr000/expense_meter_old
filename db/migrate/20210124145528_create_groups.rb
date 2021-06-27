class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :customer_email, null: false, foreign_key: true
      t.string :name
      t.string :token

      t.timestamps
    end
    add_foreign_key :expenses, :groups
  end
end

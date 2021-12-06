class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :group
      t.references :category, null: false, foreign_key: true
      t.date :date
      t.string :title
      t.float :amount
      t.string :description

      t.timestamps
    end
  end
end

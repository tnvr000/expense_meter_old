class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.references :customer, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end

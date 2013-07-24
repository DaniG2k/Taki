class CreateTutors < ActiveRecord::Migration
  def change
    create_table :tutors do |t|
      t.string :name
      t.date :birthday
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end

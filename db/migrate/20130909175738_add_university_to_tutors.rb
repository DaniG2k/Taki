class AddUniversityToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :university, :string
  end
end

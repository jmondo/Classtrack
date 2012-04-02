class AddCapEnrolledToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :cap, :integer
    add_column :courses, :enrolled, :integer
  end
end

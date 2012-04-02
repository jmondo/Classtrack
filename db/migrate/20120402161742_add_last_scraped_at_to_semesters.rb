class AddLastScrapedAtToSemesters < ActiveRecord::Migration
  def change
    add_column :semesters, :last_enrollment_scraped_at, :datetime

    add_column :semesters, :last_information_scraped_at, :datetime

  end
end

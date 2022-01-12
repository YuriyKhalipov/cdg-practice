class CreateLabReports < ActiveRecord::Migration[7.0]
  def change
    create_table :lab_reports do |t|
      t.string :title
      t.text :description
      t.string :grade
      t.timestamps
    end
  end
end

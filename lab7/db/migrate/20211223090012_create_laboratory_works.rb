# Миграция для создания в БД таблицы для сущностей "Лабораторные работы"
class CreateLaboratoryWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :laboratory_works do |t|
      t.string :title
      t.text :text
      t.string :mark
      t.timestamps null: true
    end
  end
end

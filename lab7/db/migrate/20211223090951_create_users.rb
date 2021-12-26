# Миграция для создания в БД таблицы для сущностей "Пользователь" (Студент)
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :email

      t.timestamps null: true
    end

    add_column :laboratory_works, :user_id, :integer
    add_foreign_key :laboratory_works, :users
  end
end

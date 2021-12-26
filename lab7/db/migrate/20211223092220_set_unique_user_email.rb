# Миграция для установки уникальности в эмейла таблицы "Пользователь" (Студент)
class SetUniqueUserEmail < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |u|
      u.index :email, unique: true
    end
  end
end

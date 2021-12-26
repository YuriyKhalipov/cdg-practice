# Фабрика создания сущностей "Пользователь" (студент) для тестов
FactoryBot.define do
  factory :user do
    last_name { FFaker::Internet.name }
    first_name { FFaker::Name.name }
    email { FFaker::Internet.email }
  end
end

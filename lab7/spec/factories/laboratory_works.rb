# Фабрика создания сущностей "Лабораторная работа" для тестов
FactoryBot.define do
  factory :laboratory_work do
    association :user

    title { FFaker::Book.title }
    text { FFaker::Lorem.sentence }
  end
end

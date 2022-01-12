FactoryBot.define do
  factory :lab_report do
    association :user

    title { FFaker::Book.title }
    description { FFaker::Lorem.sentence }
  end
end
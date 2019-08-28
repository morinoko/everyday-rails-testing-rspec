FactoryBot.define do
  factory :user do
    first_name "Felice"
    last_name "Forby"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "dottle-nouveau-pavilion-tights-furze"
  end
end

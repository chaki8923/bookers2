FactoryBot.define do
  factory :notification do
    title { "Notification Title" }
    body { "Notification Body" }
    association :group, factory: :group
  end
end
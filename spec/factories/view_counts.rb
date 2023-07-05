FactoryBot.define do
  factory :view_count do
    user
    book
    count { 10 }
  end
end

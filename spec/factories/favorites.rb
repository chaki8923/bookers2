FactoryBot.define do
  factory :favorite do
    # favoriteの属性に適切な値を設定する
    user
    book
  end
end

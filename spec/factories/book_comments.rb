# spec/factories/book_comments.rb

FactoryBot.define do
  factory :book_comment do
    # ファクトリの属性を定義
    comment { 'YHAAAAA!' }
    association :user
    association :book
  end
end

FactoryBot.define do
  factory :chat do
    message { "Hello!" }
    sender { association(:user) }
    receiver { association(:user) }
  end
end

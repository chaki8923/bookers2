require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'associations' do
    it 'belongs to sender' do
      sender = create(:user)
      chat = create(:chat, sender: sender)
      expect(chat.sender).to eq(sender)
    end

    it 'belongs to receiver' do
      receiver = create(:user)
      chat = create(:chat, receiver: receiver)
      expect(chat.receiver).to eq(receiver)
    end
  end

  describe 'validations' do
    it 'validates presence of message' do
      chat = build(:chat, message: nil)
      expect(chat).not_to be_valid
      expect(chat.errors[:message]).to include("can't be blank")
    end
  end
end
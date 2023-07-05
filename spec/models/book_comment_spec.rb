require 'rails_helper'
RSpec.describe BookComment, type: :model do
  let(:user) { User.create(name: 'Test User') }
  let(:book) { Book.create(title: 'Test Book') }

  describe 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'belongs to book' do
      association = described_class.reflect_on_association(:book)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('Book')
    end
  end

  describe 'validations' do
    it 'validates presence of message' do
      book_comment = build(:book_comment, comment: nil)
      expect(book_comment).not_to be_valid
      expect(book_comment.errors[:comment]).to include("can't be blank")
    end
  end
end
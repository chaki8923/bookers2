require 'rails_helper'
RSpec.describe ViewCount, type: :model do
  describe 'associations' do
    it 'belongs to book' do
      association = described_class.reflect_on_association(:book)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'methods' do
    describe '.increment_count' do
      let(:book) { create(:book) }


      it 'increments the count by 1 for an existing view_count' do
        view_count = create(:view_count, book: book, count: 2)

        expect {
          described_class.increment_count(book)
        }.not_to change { described_class.count }

        view_count.reload
        expect(view_count.count).to eq(3)
      end
    end
  end
end

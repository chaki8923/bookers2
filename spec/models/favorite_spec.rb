require 'rails_helper'
RSpec.describe Favorite, type: :model do
  describe 'associations' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }
    let!(:favorite) { create(:favorite, user: user, book: book) }

    it 'belongs to user' do
      expect(Favorite.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it 'belongs to book' do
      expect(Favorite.reflect_on_association(:book).macro).to eq(:belongs_to)
    end
  end
end
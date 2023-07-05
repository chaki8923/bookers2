require 'rails_helper'
RSpec.describe 'Bookモデルテスト', type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book, user: user) }

  describe '#favorited_by?' do
    it 'ユーザーによってお気に入り登録されている場合、trueを返すこと' do
      FactoryBot.create(:favorite, user: user, book: book)
      expect(book.favorited_by?(user)).to eq(true)
    end

    it 'ユーザーによってお気に入り登録されていない場合、falseを返すこと' do
      other_user = create(:user)
      expect(book.favorited_by?(other_user)).to eq(false)
    end
  end

  describe '#total_favorites_last_week' do
    it '直近1週間のお気に入りの総数を返すこと' do
      create(:favorite, book: book, created_at: 2.days.ago)
      create(:favorite, book: book, created_at: 5.days.ago)
      create(:favorite, book: book, created_at: 8.days.ago)
      expect(book.total_favorites_last_week).to eq(2)
    end
  end

  describe '#safe_view_count' do
    it '最初のview_countレコードのカウントを返すこと。レコードが存在しない場合は0を返すこと' do
      create(:view_count, book: book, count: 10)
      expect(book.safe_view_count).to eq(10)
    end

    it 'view_countレコードが存在しない場合、0を返すこと' do
      expect(book.safe_view_count).to eq(0)
    end
  end
end

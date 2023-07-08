require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#post_books_count' do
    let(:user) { create(:user) }
    
    it 'ユーザーの今日の投稿数を取得できること' do
      create_list(:book, 3, user: user, created_at: Date.today)
      expect(user.post_books_count(user.id, 'today')).to eq(3)
    end
    
    it 'ユーザーの昨日の投稿数を取得できること' do
      create_list(:book, 2, user: user, created_at: Date.yesterday)
      expect(user.post_books_count(user.id, 'yesterday')).to eq(2)
    end
    
    it 'ユーザーの先週の投稿数を取得できること' do
      create_list(:book, 4, user: user, created_at: (Date.today - 1.week).beginning_of_week)
      expect(user.post_books_count(user.id, 'last_week')).to eq(4)
    end
    
     it 'ユーザーの先週の投稿数を取得できること' do
      create_list(:book, 4, user: user, created_at: (Date.today - 1.week).end_of_week)
      expect(user.post_books_count(user.id, 'last_week')).to eq(4)
    end
    
    it 'ユーザーの今週の投稿数を取得できること' do
      create_list(:book, 5, user: user, created_at: Date.today.beginning_of_week..Date.today.end_of_week)
      expect(user.post_books_count(user.id, 'this_week')).to eq(5)
    end
  end
  
  describe '#week_day_count' do
    let(:user) { create(:user) }
    
    it 'ユーザーのn日前の投稿数を取得できること' do
      create_list(:book, 2, user: user, created_at: Date.today - 2.days)
      expect(user.week_day_count(user.id, 2)).to eq(2)
    end
  end
end

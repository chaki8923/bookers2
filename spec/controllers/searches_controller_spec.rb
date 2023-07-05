require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  before do
    sign_in(user)
  end
  

  describe 'GET #index' do
    context 'キーワード検索の場合' do
      it 'ユーザーをキーワードで前方一致検索すること' do
        get :index, params: { keyword: 'John', category: 'user', match_type: 'prefix' }
        expect(assigns(:results)).to eq(User.where('name LIKE ?', 'John%'))
      end

      it '本をキーワードで部分一致検索すること' do
        get :index, params: { keyword: 'Ruby', category: 'book', match_type: 'partial' }
        expect(assigns(:results)).to eq(Book.where('title LIKE ?', '%Ruby%'))
      end

      it 'デフォルトの検索ロジックで検索すること' do
        get :index, params: { keyword: 'Ruby', category: 'unknown' }
        expect(assigns(:results)).to eq(Book.where('title LIKE ?', '%Ruby%'))
      end
    end

    context 'タグ検索の場合' do
      it 'タグで部分一致検索すること' do
        get :index, params: { tags: 'tag1', category: 'book!!' }
        expect(assigns(:results)).to eq(Book.where('tags LIKE ?', '%tag1%'))
      end
    end
  end
end

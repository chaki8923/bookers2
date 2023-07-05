require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  let(:favorite) { create(:favorite, user: user, book: book) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context '正常なリクエストが送信された場合' do
      it 'お気に入りが作成されること' do
        expect {
          post :create, params: { book_id: book.id }, format: :js
        }.to change(Favorite, :count).by(1)
      end

      it 'JavaScriptのレスポンスが返されること' do
        post :create, params: { book_id: book.id }, format: :js
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include('text/javascript')
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      favorite
    end

    context '正常なリクエストが送信された場合' do
      it 'お気に入りが削除されること' do
        expect {
          delete :destroy, params: { book_id: book.id }, format: :js
        }.to change(Favorite, :count).by(-1)
      end

      it 'JavaScriptのレスポンスが返されること' do
        delete :destroy, params: { book_id: book.id }, format: :js
        expect(response).to have_http_status(:success)
        expect(response.content_type).to include('text/javascript')
      end
    end
  end
end

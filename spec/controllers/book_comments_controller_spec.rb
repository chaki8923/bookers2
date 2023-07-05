require 'rails_helper'

RSpec.describe BookCommentsController, type: :controller do
  let(:book) { create(:book) }
  let(:user) { create(:user) }

  describe 'POST #create' do
    context 'when comment is valid' do
      before do
        sign_in(user)
        post :create, params: { book_id: book.id, book_comment: { comment: 'Great book!' }, format: :js }
      end

      it 'creates a new book comment' do
        expect(BookComment.count).to eq(1)
      end

      it 'renders the create.js.erb template' do
        expect(response).to render_template('create')
      end
    end

    context 'when comment is invalid' do
      before do
        sign_in(user)
        post :create, params: { book_id: book.id, book_comment: { comment: '' }, format: :js }
      end

      it 'does not create a new book comment' do
        expect(BookComment.count).to eq(0)
      end

      it 'renders the layouts/error.js.erb template' do
        expect(response).to render_template('layouts/error')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:book_comment) { create(:book_comment, user: user, book: book) }

    before do
      sign_in(user)
      delete :destroy, params: { book_id: book.id, id: book_comment.id }
    end

    it 'destroys the book comment' do
      expect(BookComment.count).to eq(0)
    end

    it 'redirects back to the previous page' do
      expect(response).to redirect_to(book_path(book))
    end
  end
end

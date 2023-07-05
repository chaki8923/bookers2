require 'rails_helper'

RSpec.describe ViewCountsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }
  before do
    sign_in(user)
  end
  
  describe 'POST #create' do
    it '指定した本の閲覧数をインクリメントすること' do
      view_count = create(:view_count, book: book, count: 10)

      expect {
        post :create, params: { book_id: book.id }
      }.to change { view_count.reload.count }.by(1)
    end
  end
end
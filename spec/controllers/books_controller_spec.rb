require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  
  before do
    sign_in user
  end
  describe 'GET #show' do
    let(:book) { create(:book) } # テスト用のBookオブジェクトを作成

    it 'assigns the requested book to @book' do
      get :show, params: { id: book.id }
      expect(response).to be_successful
      
    end

    it 'assigns a new Book object to @new_form_book' do
      get :show, params: { id: book.id }
      expect(assigns(:new_form_book)).to be_a_new(Book)
    end

    it 'assigns a new BookComment object to @book_comment' do
      get :show, params: { id: book.id }
      expect(assigns(:book_comment)).to be_a_new(BookComment)
    end

    it 'increments the view count for the book' do
      expect {
        get :show, params: { id: book.id }
      }.to change { book.view_counts.count }.by(1)
    end

    it 'renders the show template' do
      get :show, params: { id: book.id }
      expect(response).to render_template(:show)
    end
  end
  
  describe 'POST #create' do
    context 'when book is valid' do
      before do
        post :create, params: { book: attributes_for(:book) }
      end

      it 'creates a new book' do
        expect(Book.count).to eq(1)
      end

      it 'redirects to the created book page' do
        book = Book.last
        expect(response).to redirect_to(book_path(book))
      end

      it 'sets the flash notice message' do
        expect(flash[:notice]).to eq("You have created book successfully.")
      end
    end

    context 'when book is invalid' do
      before do
        post :create, params: { book: { title: '', body: '' } }
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end
    
    describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all books to @books' do
      book1 = FactoryBot.create(:book)
      book2 = FactoryBot.create(:book)
      get :index
      expect(assigns(:books)).to match_array([book1, book2])
    end
  end
  
  describe 'GET edit' do
    context 'when the user is the owner of the book' do
      it 'renders the edit template' do
        user = FactoryBot.create(:user)
        book = FactoryBot.create(:book, user: user)
        allow(controller).to receive(:current_user).and_return(user)
        get :edit, params: { id: book.id }
        expect(response).to render_template(:edit)
      end
    end
  
    context 'when the user is not the owner of the book' do
      it 'redirects to the books index page' do
        user = FactoryBot.create(:user)
        book = FactoryBot.create(:book, user: FactoryBot.create(:user))
        allow(controller).to receive(:current_user).and_return(user)
        get :edit, params: { id: book.id }
        expect(response).to redirect_to(books_path)
      end
    end
  end

  describe 'PATCH update' do
    let(:book) { FactoryBot.create(:book) }

    it 'updates the book' do
      new_title = 'New Title'
      patch :update, params: { id: book.id, book: { title: new_title } }
      book.reload
      expect(book.title).to eq(new_title)
    end

    it 'redirects to the book show page' do
      patch :update, params: { id: book.id, book: { title: 'New Title' } }
      expect(response).to redirect_to(book_path(book))
    end
  end

  describe 'DELETE destroy' do
    let!(:book) { FactoryBot.create(:book) }

    it 'deletes the book' do
      expect {
        delete :destroy, params: { id: book.id }
      }.to change(Book, :count).by(-1)
    end

    it 'redirects to the books index page' do
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(books_path)
    end
  end
  end
end

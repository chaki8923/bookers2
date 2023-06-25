class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @new_form_book = Book.new
    @book_comment = BookComment.new
    increment_view_count(@book)
  end

  def index
    @book =  Book.new
    @books = Book.all.sort_by { |book| -book.total_favorites_last_week }
    # @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path, notice: "You can't edit other user's book."
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end
  
  def increment_view_count(book)
    view_count = book.view_counts.find_or_create_by(book_id: book.id, user_id: current_user.id)
    view_count.increment!(:count)
    view_count.save
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end

class BooksController < ApplicationController

  def show
    begin
      @book = Book.find(params[:id])
      @new_form_book = Book.new
      @book_comment = BookComment.new
      increment_view_count(@book)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "NOT FOUND BOOK ID ---->このidの投稿ないよ#{params[:id]}<----"
      redirect_to books_path
    end
  end

  def index
    @book =  Book.new
    @books = Book.all
    @books = @books.all.sort_by { |book| -book.total_favorites_last_week } if params[:sort].nil?
    @books = @books.order(created_at: :desc) if params[:sort] == 'latest'
    @books = @books.order(star: :desc) if params[:sort] == 'star'
    @books = Book.where('tags LIKE ?', "%#{params[:tags]}%") if params[:tags].present?
    # @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      url = request.referrer
      ## TODO：あとで消す
      if url.present? && url.include?('books')
        # booksコントローラから呼び出された場合の処理
        render 'index'
      elsif url.present? && url.include?('users')
        # usersコントローラから呼び出された場合の処理
        flash[:error] = @book.errors.full_messages.join(", ")
        redirect_to users_path
      else
        # その他のコントローラから呼び出された場合の処理
         render 'index'
      end
      
    end
  end

  def edit
    begin
      @book = Book.find(params[:id])
      if @book.user.id != current_user.id
        redirect_to books_path, notice: "You can't edit other user's book."
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "TOU CAN NOT EDIT THIS BOOK ---->このidの投稿ないよ#{params[:id]}<----"
      redirect_to books_path
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
    params.require(:book).permit(:title, :body, :star, :tags)
  end
end

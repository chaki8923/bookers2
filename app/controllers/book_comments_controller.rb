class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @book_comment = BookComment.new
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render 'layouts/error' }
      end# 追加
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.find(params[:id])
    @book_comment.destroy
    redirect_to request.referer
  end
  
  private
  
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end

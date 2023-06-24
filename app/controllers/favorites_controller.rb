class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.build(book: @book)
    @favorite.save
    respond_to do |format|
      format.js   # 追加
    end
  end
  
  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: params[:book_id])
    @favorite.destroy
    respond_to do |format|
      format.js   # 追加
    end
  end
  
  private
  

end

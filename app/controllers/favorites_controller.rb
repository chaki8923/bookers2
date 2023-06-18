class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.build(book: @book)
    @favorite.save
    redirect_to request.referer
  end
  
  def destroy
    @favorite = current_user.favorites.find_by(book_id: params[:book_id])
    @favorite.destroy
    redirect_to request.referer
  end
  
  private
  

end

class ViewCountsController < ApplicationController
  def create
    @book = Book.find(params[:book_id]) 
    @view_count = @book.view_count || @book.build_view_count
    @view_count.count += 1
    @view_count.save
    
  end

end

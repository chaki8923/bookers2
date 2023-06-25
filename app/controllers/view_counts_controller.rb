class ViewCountsController < ApplicationController
  def create
    @book = Book.find(params[:book_id]) # 投稿を取得するメソッド（詳細は後述）
    @view_count = @book.view_count || @book.build_view_count
    @view_count.count += 1
    @view_count.save
    
  end

end

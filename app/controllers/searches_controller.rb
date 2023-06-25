class SearchesController < ApplicationController
  def index
    keyword = params[:keyword]
    @category = params[:category]
    match_type = params[:match_type]
    @results = search(keyword, @category, match_type)

    render 'searches/index'
  end
  
  
  private
  def search(keyword, category, match_type)
    if category == 'user'
      case match_type
      when 'prefix'
        User.where('name LIKE ?', "#{keyword}%")
      when 'suffix'
        User.where('name LIKE ?', "%#{keyword}")
      when 'exact'
        User.where(name: keyword)
      when 'partial'
        User.where('name LIKE ?', "%#{keyword}%")
      else
        # デフォルトの検索ロジック
        User.where('name LIKE ?', "%#{keyword}%")
      end
    elsif category == 'book'
      # 本に関連する検索ロジック
      case match_type
      when 'prefix'
        Book.where('title LIKE ?', "#{keyword}%")
      when 'suffix'
        Book.where('title LIKE ?', "%#{keyword}")
      when 'exact'
        Book.where(title: keyword)
      when 'partial'
        Book.where('title LIKE ?', "%#{keyword}%")
      else
        # デフォルトの検索ロジック
        Book.where('title LIKE ?', "%#{keyword}%")
      end
    else
      # デフォルトの検索ロジック
      Book.where('title LIKE ?', "%#{keyword}%")
    end
  end
end

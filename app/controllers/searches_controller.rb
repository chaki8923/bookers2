class SearchesController < ApplicationController
  def index
    keyword = params[:keyword]
    @category = params[:category]
    match_type = params[:match_type]
    @tag = params[:tags]
    @results = search(keyword, @category, match_type, @tag)
    ## TODO：あとで消す
    Rails.logger.debug "@results---------------------------------#{@results}"

    render 'searches/index'
  end
  
  
  private
  
  def search(keyword, category, match_type, tags)
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
    elsif tags.present?
       Book.where('tags LIKE ?', "%#{tags}%")
    else
      # デフォルトの検索ロジック
      Book.where('title LIKE ?', "%#{keyword}%")
    end
  end
end
